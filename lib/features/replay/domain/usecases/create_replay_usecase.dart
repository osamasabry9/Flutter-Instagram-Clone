import '../entities/replay_entity.dart';
import '../repositories/replay_repository.dart';

class CreateReplayUseCase {
  final ReplayRepository repository;

  CreateReplayUseCase({required this.repository});

  Future<void> call(ReplayEntity replay) {
    return repository.createReplay(replay);
  }
}