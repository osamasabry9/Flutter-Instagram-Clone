
import '../entities/post_entity.dart';
import '../repository/post_firebase_repository.dart';

class CreatePostUseCase {
  final PostFirebaseRepository repository;

  CreatePostUseCase({required this.repository});

  Future<void> call(PostEntity post) {
    return repository.createPost(post);
  }
}