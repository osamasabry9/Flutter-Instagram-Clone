import '../entities/story_entity.dart';
import '../repository/story_firebase_repository.dart';

class ReadSingleStoryUseCase {
  final StoryRepository repository;

  ReadSingleStoryUseCase({required this.repository});

  Stream<List<StoryEntity>> call(String storyId) {
    return repository.readSingleStory(storyId);
  }
}
