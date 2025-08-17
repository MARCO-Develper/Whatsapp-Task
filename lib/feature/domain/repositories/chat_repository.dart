import 'package:dartz/dartz.dart';
import 'package:whatsapp_task/core/error/failures.dart';
import '../entities/chat.dart';
import '../entities/message.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<Chat>>> getAllChats();
  Future<Either<Failure, Chat>> getChatById(String chatId);
  Future<Either<Failure, List<Message>>> getMessagesForChat(String chatId);
  Future<Either<Failure, Message>> sendMessage(
      String chatId, String messageText);
}
