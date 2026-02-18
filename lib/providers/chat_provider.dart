import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:uuid/uuid.dart';
import 'package:bubbles/models/chat.dart';
import 'package:bubbles/models/chat_mode.dart';
import 'package:bubbles/models/message.dart';
import 'package:bubbles/services/chat_storage_service.dart';
import 'package:bubbles/services/open_ai.services.dart';

final chatStorageServiceProvider = Provider((ref) => ChatStorageService());
final openAIServiceProvider = Provider((ref) => OpenAIService());

final chatsProvider = NotifierProvider<ChatsNotifier, AsyncValue<List<Chat>>>(
  ChatsNotifier.new,
);

final historyEnabledProvider = StateProvider<bool>((ref) => true);

class ChatsNotifier extends Notifier<AsyncValue<List<Chat>>> {
  late final ChatStorageService _storageService;

  @override
  AsyncValue<List<Chat>> build() {
    _storageService = ref.read(chatStorageServiceProvider);
    loadChats();
    return const AsyncValue.loading();
  }

  Future<void> loadChats() async {
    state = const AsyncValue.loading();
    try {
      final chats = await _storageService.loadChats();
      state = AsyncValue.data(chats);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> addChat(Chat chat) async {
    final currentChats = state.value ?? [];
    final updatedChats = [chat, ...currentChats];
    state = AsyncValue.data(updatedChats);
    await _storageService.saveChats(updatedChats);
  }

  Future<void> updateChat(Chat updatedChat) async {
    final currentChats = state.value ?? [];
    final index = currentChats.indexWhere((c) => c.id == updatedChat.id);
    if (index != -1) {
      currentChats[index] = updatedChat;
      state = AsyncValue.data([...currentChats]);
      await _storageService.saveChats(currentChats);
    }
  }

  Future<void> deleteChat(String chatId) async {
    final currentChats = state.value ?? [];
    currentChats.removeWhere((c) => c.id == chatId);
    state = AsyncValue.data([...currentChats]);
    await _storageService.deleteChat(chatId);
  }

  Chat? getChatById(String chatId) {
    final chats = state.value ?? [];
    try {
      return chats.firstWhere((c) => c.id == chatId);
    } catch (e) {
      return null;
    }
  }

  List<Chat> getChatsByMode(ChatMode mode) {
    final chats = state.value ?? [];
    return chats.where((c) => c.mode == mode).toList();
  }
}

final currentChatProvider = StateProvider<Chat?>((ref) => null);

final chatMessagesProvider =
    NotifierProvider<ChatMessagesNotifier, List<Message>>(
      ChatMessagesNotifier.new,
    );

class ChatMessagesNotifier extends Notifier<List<Message>> {
  late final OpenAIService _openAIService;
  late final ChatsNotifier _chatsNotifier;
  bool _isProcessing = false;

  @override
  List<Message> build() {
    _openAIService = ref.read(openAIServiceProvider);
    _chatsNotifier = ref.read(chatsProvider.notifier);
    return [];
  }

  void setMessages(List<Message> messages) {
    state = messages;
  }

  bool get isProcessing => _isProcessing;

  Future<void> sendMessage(String content, ChatMode mode, String chatId) async {
    if (_isProcessing || content.trim().isEmpty) return;

    _isProcessing = true;
    final userMessage = Message(
      id: const Uuid().v4(),
      content: content,
      isUser: true,
      timestamp: DateTime.now(),
    );

    state = [...state, userMessage];

    try {
      final aiResponse = await _openAIService.sendMessage(mode, state, content);

      final aiMessage = Message(
        id: const Uuid().v4(),
        content: aiResponse,
        isUser: false,
        timestamp: DateTime.now(),
      );

      state = [...state, aiMessage];

      final chat = _chatsNotifier.getChatById(chatId);
      if (chat != null) {
        final updatedChat = chat.copyWith(
          messages: state,
          updatedAt: DateTime.now(),
        );
        await _chatsNotifier.updateChat(updatedChat);
      }
    } catch (e) {
      final errorMessage = Message(
        id: const Uuid().v4(),
        content: 'Sorry, I encountered an error. Please try again.',
        isUser: false,
        timestamp: DateTime.now(),
      );
      state = [...state, errorMessage];
    } finally {
      _isProcessing = false;
    }
  }
}
