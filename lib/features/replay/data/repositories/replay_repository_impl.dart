import '../../domain/entities/replay_entity.dart';
import '../../domain/repositories/replay_repository.dart';
import '../datasources/replay_remote_data_source.dart';

class ReplayRepositoryImpl implements ReplayRepository {
  final ReplayRemoteDataSource replayRemoteDataSource;

  ReplayRepositoryImpl({required this.replayRemoteDataSource});

  @override
  Future<void> createReplay(ReplayEntity replay) async =>
      replayRemoteDataSource.createReplay(replay);

  @override
  Future<void> deleteReplay(ReplayEntity replay) async =>
      replayRemoteDataSource.deleteReplay(replay);

  @override
  Future<void> likeReplay(ReplayEntity replay) async =>
      replayRemoteDataSource.likeReplay(replay);

   @override
  Stream<List<ReplayEntity>> readReplays(ReplayEntity replay) => replayRemoteDataSource.readReplays(replay);
  @override
  Future<void> updateReplay(ReplayEntity replay) async =>
      replayRemoteDataSource.updateReplay(replay);
}
