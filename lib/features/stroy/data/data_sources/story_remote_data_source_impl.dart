import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/story_entity.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/utils/constants_manager.dart';
import '../models/story_model.dart';
import 'story_remote_data_source.dart';

class StoryRemoteDataSourceImpl implements StoryRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  StoryRemoteDataSourceImpl(
      {required this.firebaseStorage,
      required this.firebaseFirestore,
      required this.firebaseAuth});

  @override
  Future<void> createStory(StoryEntity story) async {
    final storyCollection = firebaseFirestore.collection(FirebaseConst.stories);

    final newStory = StoryModel(
            userProfileUrl: story.userProfileUrl,
            username: story.username,
            storyUrl: story.storyUrl,
            storyId: story.storyId,
            isVideo: story.isVideo,
            description: story.description,
            creatorUid: story.creatorUid,
            createAt: story.createAt)
        .toJson();

    try {
      final storyDocRef = await storyCollection.doc(story.storyId).get();

      if (!storyDocRef.exists) {
        storyCollection.doc(story.storyId).set(newStory).then((value) {
          return;
        });
      } else {
        storyCollection.doc(story.storyId).update(newStory);
      }
    } catch (e) {
      debugPrint("some error occurred $e");
    }
  }

  @override
  Future<void> deleteStory(StoryEntity story) async {
    final storyCollection = firebaseFirestore.collection(FirebaseConst.stories);

    try {
      storyCollection.doc(story.storyId).delete().then((value) {
        return;
      });
    } catch (e) {
      debugPrint("some error occurred $e");
    }
  }

  Future<String> getCurrentUid() async => firebaseAuth.currentUser!.uid;
  
  @override
  Stream<List<StoryEntity>> readStories(StoryEntity story) {
    final storyCollection = firebaseFirestore
        .collection(FirebaseConst.stories)
        .orderBy("createAt", descending: true);
    return storyCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => StoryModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<StoryEntity>> readSingleStory(String storyId) {
    final storyCollection = firebaseFirestore
        .collection(FirebaseConst.stories)
        .orderBy("createAt", descending: true)
        .where("StoryId", isEqualTo: storyId);
    return storyCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => StoryModel.fromSnapshot(e)).toList());
  }

  @override
  Future<String> uploadImageStory(File? file) async {
    Reference ref = firebaseStorage
        .ref()
        .child(FirebaseConst.stories)
        .child(firebaseAuth.currentUser!.uid);

    String id = const Uuid().v1();
    ref = ref.child(id);

    final uploadTask = ref.putFile(file!);

    final imageUrl =
        (await uploadTask.whenComplete(() {})).ref.getDownloadURL();

    return await imageUrl;
  }
}
