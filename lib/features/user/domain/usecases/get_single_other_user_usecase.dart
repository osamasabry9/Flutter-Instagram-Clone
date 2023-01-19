import '../entities/user_entity.dart';
import '../repository/user_firebase_repository.dart';

class GetSingleOtherUserUseCase {
  final UserRepository repository;

  GetSingleOtherUserUseCase({required this.repository});

  Stream<List<UserEntity>> call(String otherUid) {
    return repository.getSingleOtherUser(otherUid);
  }
}
