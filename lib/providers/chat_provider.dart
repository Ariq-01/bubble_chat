import 'package:flutter/material.dart';
import '../models/message.dart';
import '../services/chat_service.dart';

class ChatProvider extends ChangeNotifier {
  final ChatService _chatService = ChatService();
  final List<Message> _messages = [];
  bool _isLoading = false;

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  Future<void> sendMessage(String text) async {
    final userMessage = Message(
      id: DateTime.now().toString(),
      text: text,
      isUser: true,
      createdAt: DateTime.now(),
    );
    _messages.add(userMessage);
    notifyListeners();

    _isLoading = true;
    notifyListeners(); // Update UI to show loading if needed (or just wait for stream)

    try {
      String fullResponse = "";
      final aiMessageId = DateTime.now().toString() + "_ai";

      // Use a temporary placeholder or stream directly into a new message
      // Strategy: Create an empty AI message and update it as chunks arrive
      var aiMessage = Message(
        id: aiMessageId,
        text: "",
        isUser: false,
        createdAt: DateTime.now(),
      );
      _messages.add(aiMessage);
      notifyListeners();

      await for (final chunk in _chatService.sendMessageStream(text)) {
        fullResponse += chunk;

        // Update the last message (which is the AI message)
        final index = _messages.indexWhere((m) => m.id == aiMessageId);
        if (index != -1) {
          _messages[index] = Message(
            id: aiMessageId,
            text: fullResponse,
            isUser: false,
            createdAt: DateTime.now(),
          );
          notifyListeners();
        }
      }
    } catch (e) {
      print("Error streaming message: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
