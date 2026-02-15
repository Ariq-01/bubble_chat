import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key, required this.onSendMessage});
  final Function(String, String)? onSendMessage;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Type a message",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () async {
                  final text = _controller.text.trim();
                  if (text.isNotEmpty) {
                    try {
                      final result = await FirebaseFunctions.instance
                          .httpsCallable('generatedText')
                          .call({'prompt': text});
                      
                      // Pass both user message and AI response
                      widget.onSendMessage?.call(text, result.data['text']);
                      _controller.clear();
                    } catch (e) {
                      print('error: $e');
                    }
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
