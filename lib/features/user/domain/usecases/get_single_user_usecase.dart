
import '../entities/user_entity.dart';
import '../repository/user_firebase_repository.dart';

class GetSingleUserUseCase {
  final UserFirebaseRepository repository;

  GetSingleUserUseCase({required this.repository});

  Stream<List<UserEntity>> call(String uid) {
    return repository.getSingleUser(uid);
  }
}