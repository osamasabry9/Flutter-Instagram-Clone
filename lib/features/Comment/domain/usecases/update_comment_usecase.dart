import '../entities/comment_entity.dart';
import '../repository/comment_firebase_repository.dart';

class UpdateCommentUseCase {
  final CommentFirebaseRepository repository;

  UpdateCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.updateComment(comment);
  }
}