import '../entities/replay_entity.dart';
import '../repositories/replay_repository.dart';

class ReadReplaysUseCase {
  final ReplayRepository repository;

  ReadReplaysUseCase({required this.repository});

  Stream<List<ReplayEntity>> call(ReplayEntity replay) {
    return repository.readReplays(replay);
  }
}