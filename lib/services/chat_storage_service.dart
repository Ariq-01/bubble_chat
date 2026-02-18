import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bubbles/models/chat.dart';

class ChatStorageService {
  static const String _chatsKey = 'chats_history';

  Future<List<Chat>> loadChats() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final chatsJson = prefs.getString(_chatsKey);
      
      if (chatsJson == null) {
        return [];
      }

      final List<dynamic> chatsList = jsonDecode(chatsJson) as List<dynamic>;
      return chatsList.map((json) => Chat.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      debugPrint('Error loading chats: $e');
      return [];
    }
  }

  Future<void> saveChats(List<Chat> chats) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final chatsJson = jsonEncode(chats.map((chat) => chat.toJson()).toList());
      await prefs.setString(_chatsKey, chatsJson);
    } catch (e) {
      debugPrint('Error saving chats: $e');
    }
  }

  Future<void> deleteChat(String chatId) async {
    try {
      final chats = await loadChats();
      chats.removeWhere((chat) => chat.id == chatId);
      await saveChats(chats);
    } catch (e) {
      debugPrint('Error deleting chat: $e');
    }
  }

  Future<void> clearAllChats() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_chatsKey);
    } catch (e) {
      debugPrint('Error clearing chats: $e');
    }
  }
}
