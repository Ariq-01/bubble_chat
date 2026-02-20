import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/chat_provider.dart';

class ChatPage extends StatefulWidget {
  final String title;
  final String workflowSlug;

  const ChatPage({
    super.key,
    required this.title,
    required this.workflowSlug,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();
    context.read<ChatProvider>().send(text, widget.workflowSlug);
  }

  void _onBack() {
    context.read<ChatProvider>().clear(); // cancel stream + reset state
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chat = context.watch<ChatProvider>();

    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) context.read<ChatProvider>().clear();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFAFAFA),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A)),
            onPressed: _onBack,
          ),
          title: Text(
            widget.title,
            style: const TextStyle(
              color: Color(0xFF1A1A1A),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: chat.result.isEmpty && !chat.isLoading
                  ? const Center(
                      child: Text(
                        'Say something...',
                        style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 16),
                      ),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F0FE),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: chat.isLoading && chat.result.isEmpty
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Color(0xFF6B9FDB),
                                    ),
                                  )
                                : Text(
                                    chat.result,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFF1A1A1A),
                                      height: 1.5,
                                    ),
                                  ),
                          ),
                          if (chat.isLoading && chat.result.isNotEmpty)
                            const Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color(0xFF6B9FDB),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
            ),
            // Input bar
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              decoration: const BoxDecoration(
                color: Color(0xFFFAFAFA),
                border: Border(top: BorderSide(color: Color(0xFFE0E0E0))),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (_) => _send(),
                      textInputAction: TextInputAction.send,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
                        filled: true,
                        fillColor: const Color(0xFFEEEEEE),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: chat.isLoading ? null : _send,
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: chat.isLoading
                            ? const Color(0xFFCCCCCC)
                            : const Color(0xFF1A1A1A),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_upward,
                          color: Colors.white, size: 22),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


