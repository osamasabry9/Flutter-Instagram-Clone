import '../entities/comment_entity.dart';
import '../repository/comment_firebase_repository.dart';
class DeleteCommentUseCase {
  final CommentFirebaseRepository repository;

  DeleteCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.deleteComment(comment);
  }
}