import 'dart:io';

import '../../domain/entities/story_entity.dart';

abstract class StoryRemoteDataSource {
  Future<void> createStory(StoryEntity story);
  Stream<List<StoryEntity>> readStories(StoryEntity story);
  Stream<List<StoryEntity>> readSingleStory(String storyId);
  Future<void> deleteStory(StoryEntity story);
  Future<String> uploadImageStory(File? file);
}
