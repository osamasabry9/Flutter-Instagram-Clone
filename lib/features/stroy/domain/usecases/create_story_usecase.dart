import '../entities/story_entity.dart';
import '../repository/story_firebase_repository.dart';

class CreateStoryUseCase {
  final StoryRepository repository;

  CreateStoryUseCase({required this.repository});

  Future<void> call(StoryEntity story) {
    return repository.createStory(story);
  }
}
