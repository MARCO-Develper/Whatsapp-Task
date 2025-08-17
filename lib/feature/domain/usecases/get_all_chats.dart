import 'package:dartz/dartz.dart';
import 'package:whatsapp_task/core/error/failures.dart';
import 'package:whatsapp_task/core/usecases/usecase.dart';

import '../entities/chat.dart';
import '../repositories/chat_repository.dart';

class GetAllChats implements UseCase<List<Chat>, NoParams> {
  final ChatRepository repository;

  GetAllChats(this.repository);

  @override
  Future<Either<Failure, List<Chat>>> call(NoParams params) async {
    return await repository.getAllChats();
  }
}
