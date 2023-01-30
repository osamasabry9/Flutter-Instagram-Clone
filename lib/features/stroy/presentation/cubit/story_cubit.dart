import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/story_entity.dart';
import '../../domain/usecases/create_story_usecase.dart';
import '../../domain/usecases/delete_story_usecase.dart';
import '../../domain/usecases/read_stories_usecase.dart';

part 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  final CreateStoryUseCase createStoryUseCase;
  final DeleteStoryUseCase deleteStoryUseCase;
  final ReadStoriesUseCase readStoriesUseCase;
  StoryCubit({
    required this.deleteStoryUseCase,
    required this.createStoryUseCase,
    required this.readStoriesUseCase
}) : super(StoryInitial());

  Future<void> getStories({required StoryEntity story}) async {
    emit(StoryLoading());
    try {
      final streamResponse = readStoriesUseCase.call(story);
      streamResponse.listen((stories) {
        emit(StoryLoaded(stories: stories));
      });
    } on SocketException catch(_) {
      emit(StoryFailure());
    } catch (_) {
      emit(StoryFailure());
    }
  }

  Future<void> deleteStory({required StoryEntity story}) async {
    try {
      await deleteStoryUseCase.call(story);
    } on SocketException catch(_) {
      emit(StoryFailure());
    } catch (_) {
      emit(StoryFailure());
    }
  }

  Future<void> createStory({required StoryEntity story}) async {
    try {
      await createStoryUseCase.call(story);
    } on SocketException catch(_) {
      emit(StoryFailure());
    } catch (_) {
      emit(StoryFailure());
    }
  }
}
