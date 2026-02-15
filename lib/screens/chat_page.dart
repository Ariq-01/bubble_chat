import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import 'home_page.dart';

class ChatPage extends StatefulWidget {
  final String chatType;
  const ChatPage({super.key, required this.chatType});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> messages = [];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleSendMessage(String userMessage, String aiResponse) {
    setState(() {
      messages.add({'role': 'user', 'text': userMessage});
      messages.add({'role': 'ai', 'text': aiResponse});
    });
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('chat: ${widget.chatType}')),
      body: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? Center(child: Text('Start chatting with AI'))
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isUser = message['role'] == 'user';
                      return Align(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: isUser ? Colors.blue : Colors.grey[300],
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            message['text'] ?? '',
                            style: TextStyle(
                              color: isUser ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          CustomTextField(
            onSendMessage: (userMessage, aiResponse) {
              _handleSendMessage(userMessage, aiResponse);
            },
          ),
        ],
      ),
    );
  }
}
