import 'package:instagram_clone/features/chat/domain/entities/message_entity.dart';

import '../../domain/repositories/message_firebase_repository.dart';
import '../datasources/message_remote_data_source.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDataSource messageRemoteDataSource;

  MessageRepositoryImpl({required this.messageRemoteDataSource});

  @override
  Stream<List<MessageEntity>> getMessage({
    required String senderId,
    required String receiverId,
  }) =>
      messageRemoteDataSource.getMessage(
        senderId: senderId,
        receiverId: receiverId,
      );

  @override
  Future<void> sendMessage(MessageEntity message) =>
      messageRemoteDataSource.sendMessage(message);
}
