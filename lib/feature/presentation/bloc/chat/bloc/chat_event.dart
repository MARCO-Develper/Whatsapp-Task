import 'package:equatable/equatable.dart';

// Events
abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class GetChatsEvent extends ChatEvent {}

class SendMessageEvent extends ChatEvent {
  final String chatId;
  final String messageText;

  const SendMessageEvent({required this.chatId, required this.messageText});

  @override
  List<Object> get props => [chatId, messageText];
}
