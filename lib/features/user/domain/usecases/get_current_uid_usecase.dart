import '../repository/user_firebase_repository.dart';

class GetCurrentUidUseCase {
  final UserFirebaseRepository repository;

  GetCurrentUidUseCase({required this.repository});

  Future<String> call() {
    return repository.getCurrentUid();
  }
}