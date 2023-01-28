import '../../domain/entities/user_entity.dart';

import 'dart:io';

import '../../domain/repository/user_firebase_repository.dart';
import '../data_sources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl({required this.userRemoteDataSource});

  @override
  Future<void> createUser(UserEntity user) async =>
      userRemoteDataSource.createUser(user);

  @override
  Future<String> getCurrentUid() async => userRemoteDataSource.getCurrentUid();

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) =>
      userRemoteDataSource.getSingleUser(uid);

  @override
  Stream<List<UserEntity>> getUsers(UserEntity user) =>
      userRemoteDataSource.getUsers(user);
  @override
  Stream<List<UserEntity>> getSingleOtherUser(String otherUid) =>
      userRemoteDataSource.getSingleOtherUser(otherUid);

  @override
  Future<bool> isSignIn() async => userRemoteDataSource.isSignIn();

  @override
  Future<void> signInUser(UserEntity user) async =>
      userRemoteDataSource.signInUser(user);

  @override
  Future<void> signOut() async => userRemoteDataSource.signOut();

  @override
  Future<void> signUpUser(UserEntity user) async =>
      userRemoteDataSource.signUpUser(user);

  @override
  Future<void> updateUser(UserEntity user) async =>
      userRemoteDataSource.updateUser(user);

  @override
  Future<void> followUnFollowUser(UserEntity user) async =>
      userRemoteDataSource.followUnFollowUser(user);

  @override
  Future<String> uploadImageProfileToStorage(
    File? file,
  ) async =>
      userRemoteDataSource.uploadImageProfileToStorage(file);

  // @override
  // Stream<List<UserEntity>> getMyChat(String uid) =>
  //     userRemoteDataSource.getMyChat(uid);
}
