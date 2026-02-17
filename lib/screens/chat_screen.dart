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


  }


