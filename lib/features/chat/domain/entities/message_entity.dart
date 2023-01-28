import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String? senderId;
  final String? receiverId;
  final Timestamp? createAt;
  final String? text;

  const MessageEntity({
    required this.senderId,
    required this.receiverId,
    required this.createAt,
    required this.text,
  });

  @override
  List<Object?> get props => [
        senderId,
        receiverId,
        createAt,
        text,
      ];
}
