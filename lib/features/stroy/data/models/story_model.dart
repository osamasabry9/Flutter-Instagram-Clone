
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/story_entity.dart';

class StoryModel extends StoryEntity {



  const StoryModel({
    super.storyId,
    super.creatorUid,
    super.username,
    super.description,
    super.storyUrl,
    super.isVideo,
    super.createAt,
    super.userProfileUrl,
  }) ;

  factory StoryModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return StoryModel(
      createAt: snapshot['createAt'],
      creatorUid: snapshot['creatorUid'],
      description: snapshot['description'],
      userProfileUrl: snapshot['userProfileUrl'],
      isVideo: snapshot['isVideo'],
      storyUrl: snapshot['storyUrl'],
      storyId: snapshot['storyId'],
      username: snapshot['username'],
    );
  }

  Map<String, dynamic> toJson() => {
    "createAt": createAt,
    "creatorUid": creatorUid,
    "description": description,
    "userProfileUrl": userProfileUrl,
    "storyImageUrl": storyUrl,
    "storyId": storyId,
    "isVideo": isVideo,
    "username": username,
  };
}