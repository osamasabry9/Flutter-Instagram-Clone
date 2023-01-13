
import '../repository/user_firebase_repository.dart';
class IsSignInUseCase {
  final UserFirebaseRepository repository;

  IsSignInUseCase({required this.repository});

  Future<bool> call() {
    return repository.isSignIn();
  }
}