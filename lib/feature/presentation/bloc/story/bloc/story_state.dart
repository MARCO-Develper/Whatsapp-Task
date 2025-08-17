import 'package:equatable/equatable.dart';
import 'package:whatsapp_task/feature/domain/entities/story.dart';

abstract class StoryState extends Equatable {
  const StoryState();

  @override
  List<Object> get props => [];
}

class StoryInitial extends StoryState {}

class StoryLoading extends StoryState {}

class StoryLoaded extends StoryState {
  final List<Story> stories;

  const StoryLoaded({required this.stories});

  @override
  List<Object> get props => [stories];
}

class StoryError extends StoryState {
  final String message;

  const StoryError({required this.message});

  @override
  List<Object> get props => [message];
}
