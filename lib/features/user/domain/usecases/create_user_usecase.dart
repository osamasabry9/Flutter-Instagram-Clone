import '../entities/user_entity.dart';
import '../repository/user_firebase_repository.dart';

class CreateUserUseCase {
  final UserFirebaseRepository repository;

  CreateUserUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.createUser(user);
  }
}