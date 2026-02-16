import 'package:flutter/material.dart';
import '../assets/color_materials_3.dart';

class HomeUiChatModels4 extends StatelessWidget {
  const HomeUiChatModels4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(8.0),
          width: 151,
          height: 123,
          decoration: BoxDecoration(
            color: ColorMaterials3.getNeutralContainer(context),
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TODO: Add and resize logo here later
              const Text('Chat Model 4'),
              Icon(Icons.chat_bubble_outline, size: 48, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
