
import '../entities/user_entity.dart';
import '../repository/user_firebase_repository.dart';

class UpdateUserUseCase {
  final UserFirebaseRepository repository;

  UpdateUserUseCase({required this.repository});

  Future<void> call(UserEntity userEntity) {
    return repository.updateUser(userEntity);
  }
}