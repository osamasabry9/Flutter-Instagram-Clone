
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/post_entity.dart';

class PostModel extends PostEntity {



  const PostModel({
    super.postId,
    super.creatorUid,
    super.username,
    super.description,
    super.postImageUrl,
    super.likes,
    super.totalLikes,
    super.totalComments,
    super.createAt,
    super.userProfileUrl,
  }) ;

  factory PostModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PostModel(
      createAt: snapshot['createAt'],
      creatorUid: snapshot['creatorUid'],
      description: snapshot['description'],
      userProfileUrl: snapshot['userProfileUrl'],
      totalLikes: snapshot['totalLikes'],
      totalComments: snapshot['totalComments'],
      postImageUrl: snapshot['postImageUrl'],
      postId: snapshot['postId'],
      username: snapshot['username'],
      likes: List.from(snap.get("likes")),
    );
  }

  Map<String, dynamic> toJson() => {
    "createAt": createAt,
    "creatorUid": creatorUid,
    "description": description,
    "userProfileUrl": userProfileUrl,
    "totalLikes": totalLikes,
    "totalComments": totalComments,
    "postImageUrl": postImageUrl,
    "postId": postId,
    "likes": likes,
    "username": username,
  };
}