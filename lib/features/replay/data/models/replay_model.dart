import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/replay_entity.dart';

class ReplayModel extends ReplayEntity {
  const ReplayModel({
    super.creatorUid,
    super.replayId,
    super.commentId,
    super.postId,
    super.description,
    super.username,
    super.userProfileUrl,
    super.likes,
    super.createAt,
  });

  factory ReplayModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ReplayModel(
      postId: snapshot['postId'],
      creatorUid: snapshot['creatorUid'],
      description: snapshot['description'],
      userProfileUrl: snapshot['userProfileUrl'],
      commentId: snapshot['commentId'],
      replayId: snapshot['replayId'],
      createAt: snapshot['createAt'],
      username: snapshot['username'],
      likes: List.from(snap.get("likes")),
    );
  }

  Map<String, dynamic> toJson() => {
        "creatorUid": creatorUid,
        "description": description,
        "userProfileUrl": userProfileUrl,
        "commentId": commentId,
        "createAt": createAt,
        "replayId": replayId,
        "postId": postId,
        "likes": likes,
        "username": username,
      };
}
