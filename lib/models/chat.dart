import 'package:bubbles/models/message.dart';

class Chat {
  final String id;
  final String mode;
  final List<Message> messages; // TO DO ASK ABOUT WHT <> AND WHY THE NAME IS SAME?
  final DateTime createdAt;
  final DateTime updatedAt;

  Chat({
    required this.id,
    required this.mode,
    required this.messages,
    required this.createdAt,
    required this.updatedAt,
  });


  Map<String, dynamic> toJson() => {
    'id': id,
    'mode': mode.name,
    'messages': messages.map((m) => m.toJson()).toList(),
    'createdAt': createdAt.toIso8601String(),
    'updatedAt' updatedAt.toIso8601String(),

  };
   factory Chat.fromJson(Map<String, dynamic> json) => Chat(id:json['id'] as String,
    mode: ChatMode.values.firstWhere((m) => m.name == json['mode']),
     messages: (json['messages'] as List).map((m) => Message.fromJson(m as Map<String, dynamic>)).toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
       updatedAt:DateTime.parse(json['updatedAt']),
   );

   Chat copyWith({
    String? id,
    ChatMode? mode,
    List<Message>? messages,
    DateTime? createdAt,
    DateTime? updateAt,


   }) => Chat(
    id: id ?? this.id,
    mode: mode ?? this.mode,
    messages: messages ?? this.messages,
    createdAt: createdAt ?? this.createdAt,
    updatedAt:  updateAt ?? this.updatedAt,
   );
}