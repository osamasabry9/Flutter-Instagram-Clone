import '../entities/story_entity.dart';
import '../repository/story_firebase_repository.dart';

class DeleteStoryUseCase {
  final StoryRepository repository;

  DeleteStoryUseCase({required this.repository});

  Future<void> call(StoryEntity story) {
    return repository.deleteStory(story);
  }
}
