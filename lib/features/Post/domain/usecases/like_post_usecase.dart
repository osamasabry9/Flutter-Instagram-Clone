import '../entities/post_entity.dart';
import '../repository/post_firebase_repository.dart';

class LikePostUseCase {
  final PostFirebaseRepository repository;

  LikePostUseCase({required this.repository});

  Future<void> call(PostEntity post) {
    return repository.likePost(post);
  }
}