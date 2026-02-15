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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    // ototmatis scroll ke paling bawah
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('chat: ${widget.chatType}')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: 4,
              itemBuilder: (context, index) =>
                  ListTile(title: Text("Pesan ke $index")),
            ),
          ),
          ElevatedButton(
            onPressed: _scrollToBottom,
            child: const Text("scrool to bootom"),
          ),
          const CustomTextField(),
        ],
      ),
    );
  }
}
