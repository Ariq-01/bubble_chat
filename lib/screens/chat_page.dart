import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String chatType;

  const ChatPage({super.key, required this.chatType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat: $chatType'),),
      body: Center(
        child: Text('anda membuka halaman chat $chatType'),
      ),
    );
  }
}