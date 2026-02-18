import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:bubbles/models/chat_mode.dart';
import 'package:bubbles/models/message.dart';

class OpenAIService {
  static const String apiKey = String.fromEnvironment('OPENAI_PROXY_API_KEY');
  static const String endpoint = String.fromEnvironment('OPENAI_PROXY_ENDPOINT');

  String _getSystemPrompt(ChatMode mode) {
    switch (mode) {
      case ChatMode.friends:
        return 'You are a friendly, supportive companion. Be warm, encouraging, and casual in your responses. Share in the joy and excitement of conversations like a close friend would.';
      case ChatMode.family:
        return 'You are a caring family member. Be nurturing, understanding, and provide thoughtful advice. Show genuine care and concern in your responses.';
      case ChatMode.lonely:
        return 'You are a compassionate listener. Be empathetic, patient, and understanding. Provide comfort and make the person feel heard and valued.';
      case ChatMode.justAsking:
        return 'You are a helpful assistant. Provide clear, concise, and accurate information. Be direct and informative while remaining friendly.';
    }
  }

  Future<String> sendMessage(ChatMode mode, List<Message> conversationHistory, String userMessage) async {
    try {
      final messages = [
        {'role': 'system', 'content': _getSystemPrompt(mode)},
        ...conversationHistory.map((msg) => {
          'role': msg.isUser ? 'user' : 'assistant',
          'content': msg.content,
        }),
        {'role': 'user', 'content': userMessage},
      ];

      final response = await http.post( 
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-4o-mini',
          'messages': messages,
          'temperature': 0.7,
          'max_tokens': 500,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
        final content = data['choices'][0]['message']['content'] as String;
        return content;
      } else {
        debugPrint('OpenAI API error: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to get response from AI: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error in sendMessage: $e');
      rethrow;
    }
  }
}
