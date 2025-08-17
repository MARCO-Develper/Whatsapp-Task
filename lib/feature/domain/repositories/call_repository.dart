import 'package:dartz/dartz.dart';
import 'package:whatsapp_task/core/error/failures.dart';

import '../entities/call.dart';

abstract class CallRepository {
  Future<Either<Failure, List<Call>>> getAllCalls();
  Future<Either<Failure, Call>> makeCall(String contactId, CallType type);
}
