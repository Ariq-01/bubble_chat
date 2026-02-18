import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bubbles/models/chat.dart';

class ChatStorageService {
  static const String _chatsKey = 'chats_hsitory';
  Future<List<Chat>> LoadChat() async{
    try {
      final prefs = await SharedPreferences.getInstance();
      final chatsJson = prefs.getString(_chatsKey);
      
      if (chatsJson == null) {
        return [];
      }
      final list<dynamic> chatsList = jsonDecode(chatsJson) as List<dynamic>;
      return chatsList.map((json) => Chat.fromJson(json as MAP<String, dynamic)).toList();
    } catch(e) {
      debugPrint("Error laoding chats: $e");
      return [];
    }
  }
Future<void> saveChats(List<Chat> chats) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final chatsJson = jsonEncode(chats.map((chat) => chat.toJson()).toList());
  } catch (e) {
    debugPrint('Error savings chat : $e');
  }
}

Future<void> saveChats(List<Chat. chats) async {
  try {
    final prefs = await LoadChats();
    chats.removeWhere((chat) => chat.id ==  ChatId);
    await saveChats(chats);
  } catch(e) {
    debugPrint('erro deletying chat $e');
  }
}



}