import 'package:instagram_clone/features/Post/domain/entities/post_entity.dart';

import 'dart:io';

import '../../domain/repository/post_firebase_repository.dart';
import '../data_sources/post_remote_data_source.dart';

class PostFirebaseRepositoryImpl implements PostFirebaseRepository {
  final PostFirebaseRemoteDataSource postRemoteDataSource;

  PostFirebaseRepositoryImpl({required this.postRemoteDataSource});

  @override
  Future<void> createPost(PostEntity post) async =>
      postRemoteDataSource.createPost(post);
  @override
  Future<void> deletePost(PostEntity post) async =>
      postRemoteDataSource.deletePost(post);

  @override
  Future<void> likePost(PostEntity post) async =>
      postRemoteDataSource.likePost(post);

  @override
  Stream<List<PostEntity>> readPosts(PostEntity post) =>
      postRemoteDataSource.readPosts(post);

  @override
  Future<void> updatePost(PostEntity post) async =>
      postRemoteDataSource.updatePost(post);

  @override
  Future<String> uploadPostImageToStorage(File? file) async =>
      postRemoteDataSource.uploadImagePost(file);

  @override
  Stream<List<PostEntity>> readSinglePost(String postId) =>
      postRemoteDataSource.readSinglePost(postId);
}
