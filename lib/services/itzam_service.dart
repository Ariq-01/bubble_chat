import 'dart:convert';
import 'dart:io';

class ItzamService {
  static const apiKey = 'itzam_a163623a-185a-4348-99fe-89f589285840_fjghm98p3vegwep4vm36hy1lva7ywich';
  static const _baseUrl = 'https://itz.am/api/v1';

  static Stream<String> streamText(String input, String workflowSlug) async* {
    final request = http.Request('POST', Uri.parse('$_baseUrl/stream/text'));
    request.headers.addAll({
      'Api-Key': _apiKey,
      'ContentType': 'application/json',
    });
    request.body = jsonEncode({'input': input, 'workflowSlug': workflowSlug});

    final response = await.http.Client().send(request);
    await for (final chunk in response.stream.transform(utf8.decoder)) {
      yield chunk;
    }
  }


}