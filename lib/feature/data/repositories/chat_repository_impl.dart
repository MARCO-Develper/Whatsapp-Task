import 'package:dartz/dartz.dart';
import 'package:whatsapp_task/core/error/failures.dart';
import 'package:whatsapp_task/feature/data/datasources/local/local_data_source.dart';

import '../../domain/entities/chat.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final LocalDataSource localDataSource;

  ChatRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Chat>>> getAllChats() async {
    try {
      final chats = await localDataSource.getAllChats();
      return Right(chats);
    } on DataParsingFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(CacheFailure('Failed to get chats: $e'));
    }
  }

  @override
  Future<Either<Failure, Chat>> getChatById(String chatId) async {
    try {
      final chats = await localDataSource.getAllChats();
      final chat = chats.firstWhere((chat) => chat.id == chatId);
      return Right(chat);
    } catch (e) {
      return Left(CacheFailure('Chat not found: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Message>>> getMessagesForChat(
      String chatId) async {
    try {
      final chats = await localDataSource.getAllChats();
      final chat = chats.firstWhere((chat) => chat.id == chatId);
      return Right(chat.messages);
    } catch (e) {
      return Left(CacheFailure('Messages not found: $e'));
    }
  }

  @override
  Future<Either<Failure, Message>> sendMessage(
      String chatId, String messageText) async {
    try {
      final message = await localDataSource.sendMessage(chatId, messageText);
      return Right(message);
    } catch (e) {
      return Left(CacheFailure('Failed to send message: $e'));
    }
  }
}
