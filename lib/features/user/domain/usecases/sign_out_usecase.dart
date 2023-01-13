
import '../repository/user_firebase_repository.dart';
class SignOutUseCase {
  final UserFirebaseRepository repository;

  SignOutUseCase({required this.repository});

  Future<void> call() {
    return repository.signOut();
  }
}