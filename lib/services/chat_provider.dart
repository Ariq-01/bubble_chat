import 'package:bubbles/services/itzam_service.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier{
  String result = '';
  bool isLoading = false;
  void send(String message) {
    result = '';
    isLoading = true;
    notifyListeners();

    ItzamService.streamText(message, 'workflowSlug').listen(
      (chunk) {
        result += chunk;
        notifyListeners();
      },
      onDone: () {
        isLoading = false;
        notifyListeners();
      },
    );
  }
}