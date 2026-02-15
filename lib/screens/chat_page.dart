import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';
import '../widgets/text_field.dart';
// import '../models/message.dart'; // Unused

class ChatPage extends StatefulWidget {
  final String chatType;
  const ChatPage({super.key, required this.chatType});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    // Scroll to bottom when new message arrives or updates
    if (_scrollController.hasClients) {
      // Small delay to ensure the list has rendered the new item/height
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('chat: ${widget.chatType}')),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, chatProvider, child) {
                // Auto-scroll on new messages (basic implementation)
                // A more robust solution would check if user is at bottom
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) => _scrollToBottom(),
                );

                return chatProvider.messages.isEmpty
                    ? const Center(
                        child: Text('Start chatting with AI (Streaming Demo)'),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: chatProvider.messages.length,
                        itemBuilder: (context, index) {
                          final message = chatProvider.messages[index];
                          final isUser = message.isUser;
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
                                message.text,
                                style: TextStyle(
                                  color: isUser ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
          CustomTextField(
            onSendMessage: (userMessage, _) {
              // We ignore the second arg because logic is now in provider
              context.read<ChatProvider>().sendMessage(userMessage);
            },
          ),
        ],
      ),
    );
  }
}
