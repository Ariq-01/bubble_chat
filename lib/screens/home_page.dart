import 'package:flutter/material.dart';
import 'chat_page.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
              Container(padding: const EdgeInsets.all(16),
              child: Image.asset(
              'assets/logo.png', height: 50,
            cacheHeight: 100,
            cacheWidth: 100,),
            //const SizedBox(height: 20,),
              ),

              const SizedBox(height: 20,),
              Text('Welcome to Bubbles', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),

              const SizedBox(height: 10,),
              // to do add 4 mdels 
              ChatButton(title: 'mode lonely', chatType: 'lonely'),
              ChatButton(title: 'Mode family', chatType: 'family'),
              ChatButton(title: 'Mode friends', chatType: 'freinds'),
              ChatButton(title: 'Mode bertanya', chatType: 'bertanya'),
              
          ],
        ),
      )),
    );
  }
}

class ChatButton extends StatelessWidget {
  final String title;
  final  String chatType;

  ChatButton({required this.title, required this.chatType});

@override 
Widget build(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(context,
      MaterialPageRoute(builder: (context) => ChatPage(chatType: chatType,)));
    },
    child: Text(title),
  );
}



}