import 'package:firebase_ai/firebase_ai.dart';

class GeminiService {
  final _model = FirebaseAI.googleAI().generativeModel(
    model: 'gemini-2.5-flash',
    ApiKey: 

  );

  Future<String> generate(String prompt) async {
    final response = await _model.generateContent([Content.text(prompt)]);
    return response.text ?? '';
  }
}
