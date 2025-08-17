import 'package:equatable/equatable.dart';

// Events
abstract class StoryEvent extends Equatable {
  const StoryEvent();

  @override
  List<Object> get props => [];
}

class GetStoriesEvent extends StoryEvent {}
