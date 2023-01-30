import 'dart:io';

import '../entities/story_entity.dart';

abstract class StoryRepository {
  // Cloud Storage Feature
  Future<String> uploadStoryImageToStorage(File? file);

  // Story Features
  Future<void> createStory(StoryEntity story);
  Stream<List<StoryEntity>> readStories(StoryEntity story);
  Stream<List<StoryEntity>> readSingleStory(String storyId);
  Future<void> deleteStory(StoryEntity story);
}
