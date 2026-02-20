import 'dart:async';
import 'package:flutter/material.dart';
import '../services/itzam_service.dart';

class ChatProvider extends ChangeNotifier {
  String result = '';
  bool isLoading = false;
  StreamSubscription<String>? _subscription;

  void send(String message, String workflowSlug) {
    // Cancel any in-flight stream before starting a new one
    _subscription?.cancel();
    result = '';
    isLoading = true;
    notifyListeners();

    _subscription = ItzamService.streamText(message, workflowSlug).listen(
      (chunk) {
        result += chunk;
        notifyListeners();
      },
      onDone: () {
        isLoading = false;
        notifyListeners();
      },
      onError: (e) {
        isLoading = false;
        result = 'Error: $e';
        notifyListeners();
      },
    );
  }

  void clear() {
    _subscription?.cancel();
    _subscription = null;
    result = '';
    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

