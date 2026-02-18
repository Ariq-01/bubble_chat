import 'package:bubbles/models/message.dart';
import 'package:bubbles/providers/chat_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/src/core.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';



class ChatScreen extends ConsumerStatefulWidget{
    final String chatId;
    const ChatScreen({super.key, required this.chatId});
    

    @override
   ConsumerState<ChatScreen> createState() => _ChatScreenState(); 
  }
  class _ChatScreenState extends ConsumerState<ChatScreen> {
    final TextEditingController _messageController = TextEditingController();
    final ScrollController _scrollController = ScrollController();

    @override
    void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final chat = ref.read(chatsProvider.notifier).getChatById(widget.chatId);
      if (chat != null) {
        ref.read(chatMessagesProvider.notifier).setMessages(chat.messages);
      }
    });
    }


    @override
    void dispose() {
      _messageController.dispose();
      _scrollController.dispose();
      super.dispose();
    }
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent, 
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn,
        );
      });
    }
  }

  void _sendMessage() {
    final content = _messageController.text.trim();
    if (content.isEmpty)  return;

    final chat = ref.read(chatsProvider.notifier).getChatById(widget.chatId);
    if (chat == null)  retunr;

    _messageController.clear();
    ref.read(chatMessagesProvider.notifier).sendMessage(content, chat.mode, widget.chatId);
    _scrollToBottom();  
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatMessagesProvider);
    final chat = ref.watch(chatsProvider.notifier).getChatById(widget.chatId);
    final isDark = Theme.of(context).brightness == Brightness.dark
  }

  }


