import '../entities/message_entity.dart';
import '../repositories/message_firebase_repository.dart';

class GetMessageUseCase {
  final MessageRepository repository;

  GetMessageUseCase({required this.repository});

  Stream<List<MessageEntity>> call({
    required String senderId,
    required String receiverId,
  }) {
    return repository.getMessage(
      senderId: senderId,
      receiverId: receiverId,
    );
  }
}
