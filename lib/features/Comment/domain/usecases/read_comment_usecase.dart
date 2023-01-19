import '../entities/comment_entity.dart';
import '../repository/comment_firebase_repository.dart';

class ReadCommentsUseCase {
  final CommentRepository repository;

  ReadCommentsUseCase({required this.repository});

  Stream<List<CommentEntity>> call(String postId) {
    return repository.readComments(postId);
  }
}
