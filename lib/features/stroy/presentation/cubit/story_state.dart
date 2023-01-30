part of 'story_cubit.dart';

abstract class StoryState extends Equatable {
  const StoryState();
}

class StoryInitial extends StoryState {
  @override
  List<Object> get props => [];
}

class StoryLoading extends StoryState {
  @override
  List<Object> get props => [];
}

class StoryLoaded extends StoryState {
  final List<StoryEntity> stories;

  const StoryLoaded({required this.stories});
  @override
  List<Object> get props => [stories];
}

class StoryFailure extends StoryState {
  @override
  List<Object> get props => [];
}


