import '../entities/comment_entity.dart';
import '../repository/comment_firebase_repository.dart';

class LikeCommentUseCase {
  final CommentFirebaseRepository repository;

  LikeCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.likeComment(comment);
  }
}