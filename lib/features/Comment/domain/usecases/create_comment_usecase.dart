import '../entities/comment_entity.dart';
import '../repository/comment_firebase_repository.dart';

class CreateCommentUseCase {
  final CommentRepository repository;

  CreateCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.createComment(comment);
  }
}
