import '../entities/post_entity.dart';
import '../repository/post_firebase_repository.dart';

class DeletePostUseCase {
  final PostFirebaseRepository repository;

  DeletePostUseCase({required this.repository});

  Future<void> call(PostEntity post) {
    return repository.deletePost(post);
  }
}