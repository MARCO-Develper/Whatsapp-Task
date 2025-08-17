import 'package:dartz/dartz.dart';
import 'package:whatsapp_task/core/error/failures.dart';
import 'package:whatsapp_task/core/usecases/usecase.dart';

import '../entities/message.dart';
import '../repositories/chat_repository.dart';

class SendMessage implements UseCase<Message, SendMessageParams> {
  final ChatRepository repository;

  SendMessage(this.repository);

  @override
  Future<Either<Failure, Message>> call(SendMessageParams params) async {
    return await repository.sendMessage(params.chatId, params.messageText);
  }
}

class SendMessageParams {
  final String chatId;
  final String messageText;

  SendMessageParams({required this.chatId, required this.messageText});
}
