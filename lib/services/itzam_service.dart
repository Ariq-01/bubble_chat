import 'dart:convert';
import 'package:http/http.dart' as http;

class ItzamService {
  static const String _apiKey =
      'itzam_a163623a-185a-4348-99fe-89f589285840_kve31c3d4uacijofihxvne0sqcyevqbodn';
  static const String _endpoint = 'https://itz.am/api/v1/stream/text';

  static Stream<String> streamText(String input, String workflowSlug) async* {
    final client = http.Client();
    try {
      final request = http.Request('POST', Uri.parse(_endpoint));
      request.headers.addAll({
        'Api-Key': _apiKey,
        'Content-Type': 'application/json',
      });
      request.body = jsonEncode({'input': input, 'workflowSlug': workflowSlug});

      final response = await client.send(request);

      // Surface HTTP errors immediately instead of silently yielding garbage
      if (response.statusCode != 200) {
        throw Exception('API error ${response.statusCode}');
      }

      await for (final raw in response.stream.transform(utf8.decoder)) {
        for (final line in raw.split('\n')) {
          final trimmed = line.trim();
          if (trimmed.startsWith('data:')) {
            final payload = trimmed.substring(5).trim();
            if (payload.isNotEmpty && payload != '[DONE]') {
              try {
                final json = jsonDecode(payload) as Map<String, dynamic>;
                final text = json['text'] as String? ?? json['output'] as String? ?? '';
                if (text.isNotEmpty) yield text;
              } catch (_) {
                yield payload;
              }
            }
          } else if (trimmed.isNotEmpty) {
            yield trimmed;
          }
        }
      }
    } finally {
      client.close(); // always close to avoid connection leak
    }
  }
}

