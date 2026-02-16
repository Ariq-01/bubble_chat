import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../assets/color_materials_3.dart';

class ChatModelCard extends StatelessWidget {
  final String title;
  final String chatType;

  const ChatModelCard({super.key, required this.title, required this.chatType});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // gw menambahankan go routes atau child dari gorouters
        Navigator.pushNamed(context, '/chat', arguments: chatType);
      },
      child: Container(
        width: 151,
        height: 123,
        decoration: BoxDecoration(
          color: ColorMaterials3.getOnBlueContainer(context),
          border: Border.all(
            color: CupertinoColors.secondarySystemFill,
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            const SizedBox(height: 8),
            const Icon(
              Icons.chat_bubble_outline,
              size: 48,
              color: Color.fromARGB(255, 241, 235, 235),
            ),
          ],
        ),
      ),
    );
  }
}
