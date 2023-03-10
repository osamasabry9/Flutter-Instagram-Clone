import 'dart:io';

import '../../domain/entities/post_entity.dart';

abstract class PostRemoteDataSource {
  Future<void> createPost(PostEntity post);
  Stream<List<PostEntity>> readPosts(PostEntity post);
  Stream<List<PostEntity>> readSinglePost(String postId);
  Future<void> updatePost(PostEntity post);
  Future<void> deletePost(PostEntity post);
  Future<void> likePost(PostEntity post);
  Future<String> uploadImagePost(File? file);
}
