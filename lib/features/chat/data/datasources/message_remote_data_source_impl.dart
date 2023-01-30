import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/message_model.dart';
import '../../domain/entities/message_entity.dart';

import '../../../../core/utils/constants_manager.dart';
import 'message_remote_data_source.dart';

class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  MessageRemoteDataSourceImpl(
      {required this.firebaseStorage,
      required this.firebaseFirestore,
      required this.firebaseAuth});

  Future<String> getCurrentUid() async => firebaseAuth.currentUser!.uid;

  @override
  Future<void> sendMessage(MessageEntity message) async {
    final currentUid = await getCurrentUid();

    MessageModel model = MessageModel(
      senderId: currentUid,
      receiverId: message.receiverId,
      createAt: message.createAt,
      text: message.text,
    );

    FirebaseFirestore.instance
        .collection(FirebaseConst.users)
        .doc(currentUid)
        .collection(FirebaseConst.chats)
        .doc(message.receiverId)
        .collection(FirebaseConst.messages)
        .add(model.toJson());

    FirebaseFirestore.instance
        .collection(FirebaseConst.users)
        .doc(message.receiverId)
        .collection(FirebaseConst.chats)
        .doc(currentUid)
        .collection(FirebaseConst.messages)
        .add(model.toJson());
  }

  @override
  Stream<List<MessageEntity>> getMessage({
    required String senderId,
    required String receiverId,
  }) {
    final messageCollection = firebaseFirestore
        .collection(FirebaseConst.users)
        .doc(senderId)
        .collection(FirebaseConst.chats)
        .doc(receiverId)
        .collection(FirebaseConst.messages)
        .orderBy(
          "createAt",
        );
    return messageCollection.snapshots().map(
      (querySnapshot) {
        return querySnapshot.docs.map((queryDocumentSnapshot) {
          return MessageModel.fromSnapshot(queryDocumentSnapshot);
        }).toList();
      },
    );
  }
}
