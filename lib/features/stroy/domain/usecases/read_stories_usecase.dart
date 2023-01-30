import '../entities/story_entity.dart';
import '../repository/story_firebase_repository.dart';

class ReadStoriesUseCase {
  final StoryRepository repository;

  ReadStoriesUseCase({required this.repository});

  Stream<List<StoryEntity>> call(StoryEntity story) {
    return repository.readStories(story);
  }
}
