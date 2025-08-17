import 'package:dartz/dartz.dart';
import 'package:whatsapp_task/core/error/failures.dart';
import 'package:whatsapp_task/feature/data/datasources/local/local_data_source.dart';

import '../../domain/entities/call.dart';
import '../../domain/repositories/call_repository.dart';

class CallRepositoryImpl implements CallRepository {
  final LocalDataSource localDataSource;

  CallRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Call>>> getAllCalls() async {
    try {
      final calls = await localDataSource.getAllCalls();
      return Right(calls);
    } on DataParsingFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(CacheFailure('Failed to get calls: $e'));
    }
  }

  @override
  Future<Either<Failure, Call>> makeCall(
      String contactId, CallType type) async {
    // In a real app, this would initiate a call
    return const Left(ServerFailure('Call functionality not implemented'));
  }
}
