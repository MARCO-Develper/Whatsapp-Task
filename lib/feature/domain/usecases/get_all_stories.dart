import 'package:dartz/dartz.dart';
import 'package:whatsapp_task/core/error/failures.dart';
import 'package:whatsapp_task/core/usecases/usecase.dart';

import '../entities/story.dart';
import '../repositories/story_repository.dart';

class GetAllStories implements UseCase<List<Story>, NoParams> {
  final StoryRepository repository;

  GetAllStories(this.repository);

  @override
  Future<Either<Failure, List<Story>>> call(NoParams params) async {
    return await repository.getAllStories();
  }
}
