import '../entities/replay_entity.dart';
import '../repositories/replay_repository.dart';

class LikeReplayUseCase {
  final ReplayRepository repository;

  LikeReplayUseCase({required this.repository});

  Future<void> call(ReplayEntity replay) {
    return repository.likeReplay(replay);
  }
}