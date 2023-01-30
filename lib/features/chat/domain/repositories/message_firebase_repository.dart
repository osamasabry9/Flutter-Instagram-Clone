import '../entities/message_entity.dart';

abstract class MessageRepository {
  Future<void> sendMessage(MessageEntity message);
  Stream<List<MessageEntity>> getMessage({
    required String senderId,
    required String receiverId,
  });

}
