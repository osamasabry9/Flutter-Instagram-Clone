import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class StoryEntity extends Equatable {
  final String? storyId;
  final String? creatorUid;
  final String? username;
  final String? description;
  final String? storyUrl;
  final bool? isVideo;
  final Timestamp? createAt;
  final String? userProfileUrl;

  const StoryEntity({
    this.storyId,
    this.creatorUid,
    this.username,
    this.description,
    this.storyUrl,
    this.isVideo,
    this.createAt,
    this.userProfileUrl,
  });

  @override
  List<Object?> get props => [
        storyId,
        creatorUid,
        username,
        description,
        storyUrl,
        isVideo,
        createAt,
        userProfileUrl,
      ];
}
