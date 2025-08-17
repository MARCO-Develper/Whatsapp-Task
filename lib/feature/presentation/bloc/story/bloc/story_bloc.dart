import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_task/core/usecases/usecase.dart';
import 'package:whatsapp_task/feature/domain/usecases/get_all_stories.dart';
import 'package:whatsapp_task/feature/presentation/bloc/story/bloc/story_event.dart';
import 'package:whatsapp_task/feature/presentation/bloc/story/bloc/story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  final GetAllStories getAllStories;

  StoryBloc({required this.getAllStories}) : super(StoryInitial()) {
    on<GetStoriesEvent>(_onGetStories);
  }

  Future<void> _onGetStories(
      GetStoriesEvent event, Emitter<StoryState> emit) async {
    emit(StoryLoading());

    final failureOrStories = await getAllStories(NoParams());

    failureOrStories.fold(
      (failure) => emit(StoryError(message: failure.message)),
      (stories) => emit(StoryLoaded(stories: stories)),
    );
  }
}
