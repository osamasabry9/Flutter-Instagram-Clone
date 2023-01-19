import '../entities/user_entity.dart';
import '../repository/user_firebase_repository.dart';

class FollowUnFollowUseCase {
  final UserRepository repository;

  FollowUnFollowUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.followUnFollowUser(user);
  }
}
