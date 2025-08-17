import '../../domain/entities/message.dart';

class MessageModel extends Message {
  const MessageModel({
    required String id,
    required String text,
    required bool isMe,
    required String time,
    MessageType type = MessageType.text,
    MessageStatus status = MessageStatus.sent,
  }) : super(
          id: id,
          text: text,
          isMe: isMe,
          time: time,
          type: type,
          status: status,
        );

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      text: json['text'],
      isMe: json['isMe'],
      time: json['time'],
      type: MessageType.values.firstWhere(
        (e) => e.toString() == 'MessageType.${json['type']}',
        orElse: () => MessageType.text,
      ),
      status: MessageStatus.values.firstWhere(
        (e) => e.toString() == 'MessageStatus.${json['status']}',
        orElse: () => MessageStatus.sent,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isMe': isMe,
      'time': time,
      'type': type.toString().split('.').last,
      'status': status.toString().split('.').last,
    };
  }
}