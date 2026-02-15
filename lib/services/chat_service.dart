import 'dart:async';

class ChatService {
  // Simulating a streaming response.
  // In a real app, this would be a WebSocket or HTTP Stream.
  Stream<String> sendMessageStream(String message) async* {
    final response =
        "This is a streaming response from the new event-driven architecture. "
        "The message you sent was: '$message'. "
        "I am sending this text chunk by chunk to demonstrate the effect.";

    // Simulate network delay before starting
    await Future.delayed(const Duration(milliseconds: 500));

    final chunks = response.split(' ');
    for (var chunk in chunks) {
      // Simulate network latency per chunk
      await Future.delayed(const Duration(milliseconds: 100));
      yield "$chunk ";
    }
  }
}
