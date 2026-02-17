import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bubbles/models/chat.dart';

class ChatStorageService {
  static const String _chatsKey = 'chats_hsitory';
  Future<List<Chat>> LoadChat() async{
    try {
      final prefs = await SharedPreferences
    }
  }


}