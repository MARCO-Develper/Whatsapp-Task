import 'package:dartz/dartz.dart';
import 'package:whatsapp_task/core/error/failures.dart';

import '../entities/story.dart';

abstract class StoryRepository {
  Future<Either<Failure, List<Story>>> getAllStories();
  Future<Either<Failure, Story>> addStory(String imageUrl);
}
