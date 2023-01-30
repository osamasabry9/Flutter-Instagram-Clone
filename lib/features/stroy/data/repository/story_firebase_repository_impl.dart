import '../../domain/entities/story_entity.dart';

import 'dart:io';

import '../../domain/repository/story_firebase_repository.dart';
import '../data_sources/story_remote_data_source.dart';

class StoryRepositoryImpl implements StoryRepository {
  final StoryRemoteDataSource storyRemoteDataSource;

  StoryRepositoryImpl({required this.storyRemoteDataSource});

  @override
  Future<void> createStory(StoryEntity story) async =>
      storyRemoteDataSource.createStory(story);
  @override
  Future<void> deleteStory(StoryEntity story) async =>
      storyRemoteDataSource.deleteStory(story);

  @override
  Stream<List<StoryEntity>> readStories(StoryEntity story) =>
      storyRemoteDataSource.readStories(story);

  @override
  Future<String> uploadStoryImageToStorage(File? file) async =>
      storyRemoteDataSource.uploadImageStory(file);

  @override
  Stream<List<StoryEntity>> readSingleStory(String storyId) =>
      storyRemoteDataSource.readSingleStory(storyId);
}
