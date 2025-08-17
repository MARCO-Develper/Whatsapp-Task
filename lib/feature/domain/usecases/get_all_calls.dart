import 'package:dartz/dartz.dart';
import 'package:whatsapp_task/core/error/failures.dart';
import 'package:whatsapp_task/core/usecases/usecase.dart';

import '../entities/call.dart';
import '../repositories/call_repository.dart';

class GetAllCalls implements UseCase<List<Call>, NoParams> {
  final CallRepository repository;

  GetAllCalls(this.repository);

  @override
  Future<Either<Failure, List<Call>>> call(NoParams params) async {
    return await repository.getAllCalls();
  }
}
