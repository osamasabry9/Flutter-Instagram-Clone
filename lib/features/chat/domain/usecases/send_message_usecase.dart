import '../entities/message_entity.dart';
import '../repositories/message_firebase_repository.dart';

class SendMessageUseCase {
  final MessageRepository repository;

  SendMessageUseCase({required this.repository});

  Future<void> call(MessageEntity comment) {
    return repository.sendMessage(comment);
  }
}