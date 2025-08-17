import 'package:equatable/equatable.dart';
import 'package:whatsapp_task/feature/domain/entities/chat.dart';
import 'package:whatsapp_task/feature/domain/entities/message.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Chat> chats;

  const ChatLoaded({required this.chats});

  @override
  List<Object> get props => [chats];
}

class ChatError extends ChatState {
  final String message;

  const ChatError({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageSent extends ChatState {
  final Message message;

  const MessageSent({required this.message});

  @override
  List<Object> get props => [message];
}
