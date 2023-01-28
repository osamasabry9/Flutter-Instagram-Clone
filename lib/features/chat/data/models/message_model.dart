import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    super.senderId,
    super.receiverId,
    super.createAt,
    super.text,
  });

  factory MessageModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return MessageModel(
      senderId: snapshot['senderId'],
      receiverId: snapshot['receiverId'],
      createAt: snapshot['createAt'],
      text: snapshot['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'createAt': createAt,
      'text': text,
    };
  }
}
