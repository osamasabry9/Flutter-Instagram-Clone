

import '../../domain/entities/message_entity.dart';

abstract class MessageRemoteDataSource {
  Future<void> sendMessage(MessageEntity message);
  Stream<List<MessageEntity>> getMessage({
    required String senderId,
    required String receiverId,
  });


}
