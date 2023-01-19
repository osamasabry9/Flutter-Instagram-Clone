import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/replay/data/datasources/replay_remote_data_source.dart';

import '../../../../core/utils/constants_manager.dart';
import '../../domain/entities/replay_entity.dart';
import '../models/replay_model.dart';

class ReplayRemoteDataSourceImpl implements ReplayRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  ReplayRemoteDataSourceImpl(
      {required this.firebaseStorage,
      required this.firebaseFirestore,
      required this.firebaseAuth});

  Future<String> getCurrentUid() async => firebaseAuth.currentUser!.uid;
  @override
  Future<void> createReplay(ReplayEntity replay) async {
    final replayCollection = firebaseFirestore
        .collection(FirebaseConst.posts)
        .doc(replay.postId)
        .collection(FirebaseConst.comment)
        .doc(replay.commentId)
        .collection(FirebaseConst.replay);

    final newReplay = ReplayModel(
            userProfileUrl: replay.userProfileUrl,
            username: replay.username,
            replayId: replay.replayId,
            commentId: replay.commentId,
            postId: replay.postId,
            likes:const [],
            description: replay.description,
            creatorUid: replay.creatorUid,
            createAt: replay.createAt)
        .toJson();

    try {
      final replayDocRef = await replayCollection.doc(replay.replayId).get();

      if (!replayDocRef.exists) {
        replayCollection.doc(replay.replayId).set(newReplay).then((value) {
          final commentCollection = firebaseFirestore
              .collection(FirebaseConst.posts)
              .doc(replay.postId)
              .collection(FirebaseConst.comment)
              .doc(replay.commentId);

          commentCollection.get().then((value) {
            if (value.exists) {
              final totalReplays = value.get('totalReplays');
              commentCollection.update({"totalReplays": totalReplays + 1});
              return;
            }
          });
        });
      } else {
        replayCollection.doc(replay.replayId).update(newReplay);
      }
    } catch (e) {
      debugPrint("some error occurred $e");
    }
  }

  @override
  Future<void> deleteReplay(ReplayEntity replay) async {
    final replayCollection = firebaseFirestore
        .collection(FirebaseConst.posts)
        .doc(replay.postId)
        .collection(FirebaseConst.comment)
        .doc(replay.commentId)
        .collection(FirebaseConst.replay);

    try {
      replayCollection.doc(replay.replayId).delete().then((value) {
        final commentCollection = firebaseFirestore
            .collection(FirebaseConst.posts)
            .doc(replay.postId)
            .collection(FirebaseConst.comment)
            .doc(replay.commentId);

        commentCollection.get().then((value) {
          if (value.exists) {
            final totalReplays = value.get('totalReplays');
            commentCollection.update({"totalReplays": totalReplays - 1});
            return;
          }
        });
      });
    } catch (e) {
      debugPrint("some error occurred $e");
    }
  }

  @override
  Future<void> likeReplay(ReplayEntity replay) async {
    final replayCollection = firebaseFirestore
        .collection(FirebaseConst.posts)
        .doc(replay.postId)
        .collection(FirebaseConst.comment)
        .doc(replay.commentId)
        .collection(FirebaseConst.replay);

    final currentUid = await getCurrentUid();

    final replayRef = await replayCollection.doc(replay.replayId).get();

    if (replayRef.exists) {
      List likes = replayRef.get("likes");
      if (likes.contains(currentUid)) {
        replayCollection.doc(replay.replayId).update({
          "likes": FieldValue.arrayRemove([currentUid])
        });
      } else {
        replayCollection.doc(replay.replayId).update({
          "likes": FieldValue.arrayUnion([currentUid])
        });
      }
    }
  }

  @override
  Stream<List<ReplayEntity>> readReplays(ReplayEntity replay) {
    final replayCollection = firebaseFirestore
        .collection(FirebaseConst.posts)
        .doc(replay.postId)
        .collection(FirebaseConst.comment)
        .doc(replay.commentId)
        .collection(FirebaseConst.replay);
    return replayCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => ReplayModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> updateReplay(ReplayEntity replay) async {
    final replayCollection = firebaseFirestore
        .collection(FirebaseConst.posts)
        .doc(replay.postId)
        .collection(FirebaseConst.comment)
        .doc(replay.commentId)
        .collection(FirebaseConst.replay);

    Map<String, dynamic> replayInfo = {};

    if (replay.description != "" && replay.description != null) {
      replayInfo['description'] = replay.description;
    }

    replayCollection.doc(replay.replayId).update(replayInfo);
  }
}
