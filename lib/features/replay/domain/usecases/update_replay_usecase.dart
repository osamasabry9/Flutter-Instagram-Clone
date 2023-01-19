import '../entities/replay_entity.dart';
import '../repositories/replay_repository.dart';

class UpdateReplayUseCase {
  final ReplayRepository repository;

  UpdateReplayUseCase({required this.repository});

  Future<void> call(ReplayEntity replay) {
    return repository.updateReplay(replay);
  }
}