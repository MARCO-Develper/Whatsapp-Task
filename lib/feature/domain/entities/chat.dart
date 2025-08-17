import 'package:whatsapp_task/feature/domain/entities/message.dart';

class Chat {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final bool isOnline;
  final int unreadCount;
  final String avatarUrl;
  final List<Message> messages;

  const Chat({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.isOnline,
    required this.unreadCount,
    required this.avatarUrl,
    required this.messages,
  });
}
