import '../entities/replay_entity.dart';
import '../repositories/replay_repository.dart';

class DeleteReplayUseCase {
  final ReplayRepository repository;

  DeleteReplayUseCase({required this.repository});

  Future<void> call(ReplayEntity replay) {
    return repository.deleteReplay(replay);
  }
}