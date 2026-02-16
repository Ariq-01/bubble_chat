import 'package:flutter/material.dart';
import 'chat_page.dart';
import '../widgets/home_ui_chat_models_4.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Image.asset(
                  'assets/logo.png',
                  height: 50,
                  cacheHeight: 100,
                  cacheWidth: 100,
                ),
                //const SizedBox(height: 20,),
              ),

              const SizedBox(height: 20),
              Text(
                'Welcome to Bubbles',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              // to do add 4 mdels
              // ChatButton(title: 'mode lonely', chatType: 'lonely'),
              //ChatButton(title: 'Mode family', chatType: 'family'),
              // ChatButton(title: 'Mode friends', chatType: 'friends'),
              //ChatButton(title: 'Mode bertanya', chatType: 'bertanya'),rw
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                children: [
                  const ChatModelCard(
                    title: 'Mode bertanya',
                    chatType: 'bertanya',
                  ),
                  const ChatModelCard(title: 'Mode family', chatType: 'family'),
                  const ChatModelCard(
                    title: 'Mode friends',
                    chatType: 'friends',
                  ),
                  const ChatModelCard(title: 'Mode lonely', chatType: 'lonely'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const List<String> chatTypes = ['lonely', 'family', 'friends', 'bertanya'];

class ChatButton extends StatelessWidget {
  final String title;
  final String chatType;

  ChatButton({required this.title, required this.chatType});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatPage(chatType: chatType)),
        );
      },
      child: Text(title),
    );
  }
}
