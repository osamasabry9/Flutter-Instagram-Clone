import '../entities/post_entity.dart';
import '../repository/post_firebase_repository.dart';

class UpdatePostUseCase {
  final PostRepository repository;

  UpdatePostUseCase({required this.repository});

  Future<void> call(PostEntity post) {
    return repository.updatePost(post);
  }
}
