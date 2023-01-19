import 'dart:io';

import '../entities/post_entity.dart';

abstract class PostRepository {
  // Cloud Storage Feature
  Future<String> uploadPostImageToStorage(File? file);

  // Post Features
  Future<void> createPost(PostEntity post);
  Stream<List<PostEntity>> readPosts(PostEntity post);
  Stream<List<PostEntity>> readSinglePost(String postId);
  Future<void> updatePost(PostEntity post);
  Future<void> deletePost(PostEntity post);
  Future<void> likePost(PostEntity post);
}
