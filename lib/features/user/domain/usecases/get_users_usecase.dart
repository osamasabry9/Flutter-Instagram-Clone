
import '../entities/user_entity.dart';
import '../repository/user_firebase_repository.dart';
class GetUsersUseCase {
  final UserFirebaseRepository repository;

  GetUsersUseCase({required this.repository});

  Stream<List<UserEntity>> call(UserEntity userEntity) {
    return repository.getUsers(userEntity);
  }
}