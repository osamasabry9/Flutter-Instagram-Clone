import '../entities/post_entity.dart';
import '../repository/post_firebase_repository.dart';

class ReadSinglePostUseCase {
  final PostRepository repository;

  ReadSinglePostUseCase({required this.repository});

  Stream<List<PostEntity>> call(String postId) {
    return repository.readSinglePost(postId);
  }
}
