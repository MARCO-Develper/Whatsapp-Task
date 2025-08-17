class Message {
  final String id;
  final String text;
  final bool isMe;
  final String time;
  final MessageType type;
  final MessageStatus status;

  const Message({
    required this.id,
    required this.text,
    required this.isMe,
    required this.time,
    this.type = MessageType.text,
    this.status = MessageStatus.sent,
  });
}

enum MessageType { text, image, audio, video, document }
enum MessageStatus { sent, delivered, read }
