import 'package:dartz/dartz.dart';
import 'package:whatsapp_task/core/error/failures.dart';
import 'package:whatsapp_task/feature/data/datasources/local/local_data_source.dart';
import '../../domain/entities/story.dart';
import '../../domain/repositories/story_repository.dart';
import '../models/story_model.dart';

class StoryRepositoryImpl implements StoryRepository {
  final LocalDataSource localDataSource;

  StoryRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Story>>> getAllStories() async {
    try {
      final stories = await localDataSource.getAllStories();
      return Right(stories);
    } on DataParsingFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(CacheFailure('Failed to get stories: $e'));
    }
  }

  @override
  Future<Either<Failure, Story>> addStory(String imageUrl) async {
    // In a real app, this would save to local storage or send to server
    final story = StoryModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: 'My Status',
      imageUrl: imageUrl,
      time: 'now',
      isViewed: false,
      isMyStory: true,
    );
    return Right(story);
  }
}
