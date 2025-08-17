import 'package:whatsapp_task/feature/domain/entities/message.dart';

import '../../domain/entities/chat.dart';
import 'message_model.dart';

class ChatModel extends Chat {
  const ChatModel({
    required String id,
    required String name,
    required String lastMessage,
    required String time,
    required bool isOnline,
    required int unreadCount,
    required String avatarUrl,
    required List<Message> messages,
  }) : super(
          id: id,
          name: name,
          lastMessage: lastMessage,
          time: time,
          isOnline: isOnline,
          unreadCount: unreadCount,
          avatarUrl: avatarUrl,
          messages: messages,
        );

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      name: json['name'],
      lastMessage: json['lastMessage'],
      time: json['time'],
      isOnline: json['isOnline'],
      unreadCount: json['unreadCount'],
      avatarUrl: json['avatarUrl'],
      messages: (json['messages'] as List)
          .map((message) => MessageModel.fromJson(message))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastMessage': lastMessage,
      'time': time,
      'isOnline': isOnline,
      'unreadCount': unreadCount,
      'avatarUrl': avatarUrl,
      'messages': messages
          .map((message) => (message as MessageModel).toJson())
          .toList(),
    };
  }
}
