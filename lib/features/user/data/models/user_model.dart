import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.uid,
    super.username,
    super.name,
    super.bio,
    super.website,
    super.email,
    super.profileUrl,
    super.followers,
    super.following,
    super.totalFollowers,
    super.totalFollowing,
    super.totalPosts,
  });

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      email: snapshot['email'],
      name: snapshot['name'],
      bio: snapshot['bio'],
      username: snapshot['username'],
      totalFollowers: snapshot['totalFollowers'],
      totalFollowing: snapshot['totalFollowing'],
      totalPosts: snapshot['totalPosts'],
      uid: snapshot['uid'],
      website: snapshot['website'],
      profileUrl: snapshot['profileUrl'],
      followers: List.from(snap.get("followers")),
      following: List.from(snap.get("following")),
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": name,
        "username": username,
        "totalFollowers": totalFollowers,
        "totalFollowing": totalFollowing,
        "totalPosts": totalPosts,
        "website": website,
        "bio": bio,
        "profileUrl": profileUrl,
        "followers": followers,
        "following": following,
      };
}
