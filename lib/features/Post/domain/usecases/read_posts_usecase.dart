import '../entities/post_entity.dart';
import '../repository/post_firebase_repository.dart';

class ReadPostsUseCase {
  final PostRepository repository;

  ReadPostsUseCase({required this.repository});

  Stream<List<PostEntity>> call(PostEntity post) {
    return repository.readPosts(post);
  }
}
