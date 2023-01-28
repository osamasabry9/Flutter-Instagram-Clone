import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram_clone/features/chat/presentation/cubit/chat_cubit.dart';

import '../features/Comment/data/data_sources/comment_remote_data_source.dart';
import '../features/Comment/data/data_sources/comment_remote_data_source_impl.dart';
import '../features/Comment/data/repository/comment_firebase_repository_impl.dart';
import '../features/Comment/domain/repository/comment_firebase_repository.dart';
import '../features/Comment/domain/usecases/create_comment_usecase.dart';
import '../features/Comment/domain/usecases/delete_comment_usecase.dart';
import '../features/Comment/domain/usecases/like_comment_usecase.dart';
import '../features/Comment/domain/usecases/read_comment_usecase.dart';
import '../features/Comment/domain/usecases/update_comment_usecase.dart';
import '../features/Comment/presentation/cubit/comment_cubit.dart';
import '../features/Post/data/data_sources/post_remote_data_source.dart';
import '../features/Post/data/data_sources/post_remote_data_source_impl.dart';
import '../features/Post/data/repository/post_firebase_repository_impl.dart';
import '../features/Post/domain/repository/post_firebase_repository.dart';
import '../features/Post/domain/usecases/create_post_usecase.dart';
import '../features/Post/domain/usecases/delete_post_usecase.dart';
import '../features/Post/domain/usecases/like_post_usecase.dart';
import '../features/Post/domain/usecases/read_posts_usecase.dart';
import '../features/Post/domain/usecases/read_single_post_usecase.dart';
import '../features/Post/domain/usecases/update_post_usecase.dart';
import '../features/Post/domain/usecases/upload_image_post_usecase.dart';
import '../features/Post/presentation/cubit/get_single_post/get_single_post_cubit.dart';
import '../features/Post/presentation/cubit/post_cubit.dart';
import '../features/chat/data/datasources/message_remote_data_source.dart';
import '../features/chat/data/datasources/message_remote_data_source_impl.dart';
import '../features/chat/data/repositories/message_firebase_repository_impl.dart';
import '../features/chat/domain/repositories/message_firebase_repository.dart';
import '../features/chat/domain/usecases/get_message_usecase.dart';
import '../features/chat/domain/usecases/send_message_usecase.dart';
import '../features/replay/data/datasources/replay_remote_data_source.dart';
import '../features/replay/data/datasources/replay_remote_data_source_impl.dart';
import '../features/replay/data/repositories/replay_repository_impl.dart';
import '../features/replay/domain/repositories/replay_repository.dart';
import '../features/replay/domain/usecases/create_replay_usecase.dart';
import '../features/replay/domain/usecases/delete_replay_usecase.dart';
import '../features/replay/domain/usecases/like_replay_usecase.dart';
import '../features/replay/domain/usecases/read_replays_usecase.dart';
import '../features/replay/domain/usecases/update_replay_usecase.dart';
import '../features/replay/presentation/cubit/replay_cubit.dart';
import '../features/user/data/data_sources/user_remote_data_source.dart';
import '../features/user/data/data_sources/user_remote_data_source_impl.dart';
import '../features/user/data/repository/user_firebase_repository_impl.dart';
import '../features/user/domain/repository/user_firebase_repository.dart';
import '../features/user/domain/usecases/create_user_usecase.dart';
import '../features/user/domain/usecases/follow_unfollow_user_usecase.dart';
import '../features/user/domain/usecases/get_current_uid_usecase.dart';
import '../features/user/domain/usecases/get_single_other_user_usecase.dart';
import '../features/user/domain/usecases/get_single_user_usecase.dart';
import '../features/user/domain/usecases/get_users_usecase.dart';
import '../features/user/domain/usecases/is_sign_in_usecase.dart';
import '../features/user/domain/usecases/sign_in_user_usecase.dart';
import '../features/user/domain/usecases/sign_out_usecase.dart';
import '../features/user/domain/usecases/sign_up_user_usecase.dart';
import '../features/user/domain/usecases/update_user_usecase.dart';
import '../features/user/domain/usecases/upload_image_profile_to_storage_usecase.dart';
import '../features/user/presentation/auth/cubit/auth/auth_cubit.dart';
import '../features/user/presentation/auth/cubit/credential/credential_cubit.dart';
import '../features/user/presentation/profile/cubit/get_single_other_user/get_single_other_user_cubit.dart';
import '../features/user/presentation/profile/cubit/get_single_user/get_single_user_cubit.dart';
import '../features/user/presentation/profile/cubit/user_cubit.dart';

final instance = GetIt.instance;

Future<void> init() async {
// ------------------------Cubits-----------------------------

  //++++++++++++++++++ User Cubit Injection
  instance.registerFactory(
    () => AuthCubit(
      signOutUseCase: instance.call(),
      isSignInUseCase: instance.call(),
      getCurrentUidUseCase: instance.call(),
    ),
  );

  instance.registerFactory(
    () => CredentialCubit(
      signUpUseCase: instance.call(),
      signInUserUseCase: instance.call(),
    ),
  );

  instance.registerFactory(
    () => UserCubit(
        updateUserUseCase: instance.call(),
        getUsersUseCase: instance.call(),
        followUnFollowUseCase: instance.call()),
  );

  instance.registerFactory(
      () => GetSingleUserCubit(getSingleUserUseCase: instance.call()));

  instance.registerFactory(() =>
      GetSingleOtherUserCubit(getSingleOtherUserUseCase: instance.call()));

  
  // Post Cubit Injection
  instance.registerFactory(
    () => PostCubit(
        createPostUseCase: instance.call(),
        deletePostUseCase: instance.call(),
        likePostUseCase: instance.call(),
        readPostUseCase: instance.call(),
        updatePostUseCase: instance.call()),
  );

  instance.registerFactory(
    () => GetSinglePostCubit(readSinglePostUseCase: instance.call()),
  );
  // Comment Cubit Injection
  instance.registerFactory(
    () => CommentCubit(
      createCommentUseCase: instance.call(),
      deleteCommentUseCase: instance.call(),
      likeCommentUseCase: instance.call(),
      readCommentsUseCase: instance.call(),
      updateCommentUseCase: instance.call(),
    ),
  );

  // Replay Cubit Injection
  instance.registerFactory(
    () => ReplayCubit(
      createReplayUseCase: instance.call(),
      deleteReplayUseCase: instance.call(),
      likeReplayUseCase: instance.call(),
      readReplaysUseCase: instance.call(),
      updateReplayUseCase: instance.call(),
    ),
  );
  // Chat Cubit Injection
  instance.registerFactory(
    () => ChatCubit(
      getMessageUseCase: instance.call(),
      sendMessageUseCase: instance.call(),
    ),
  );

  // --------------------------Use Cases--------------------

  //++++++++++++++++++++++++++++++++++++  User ++++++++++++++++++++++++++++++++++++
  instance
      .registerLazySingleton(() => SignOutUseCase(repository: instance.call()));
  instance.registerLazySingleton(
      () => IsSignInUseCase(repository: instance.call()));
  instance.registerLazySingleton(
      () => GetCurrentUidUseCase(repository: instance.call()));
  instance
      .registerLazySingleton(() => SignUpUseCase(repository: instance.call()));
  instance.registerLazySingleton(
      () => SignInUserUseCase(repository: instance.call()));
  instance.registerLazySingleton(
      () => UpdateUserUseCase(repository: instance.call()));
  instance.registerLazySingleton(
      () => GetUsersUseCase(repository: instance.call()));
  instance.registerLazySingleton(
      () => CreateUserUseCase(repository: instance.call()));
  instance.registerLazySingleton(
      () => GetSingleUserUseCase(repository: instance.call()));
  instance.registerLazySingleton(
      () => FollowUnFollowUseCase(repository: instance.call()));
  instance.registerLazySingleton(
      () => GetSingleOtherUserUseCase(repository: instance.call()));
  instance.registerLazySingleton(
      () => UploadImageProfileToStorageUseCase(repository: instance.call()));

  // ++++++++++++++++++++++++++++++++++++  Post ++++++++++++++++++++++++++++++++++++
  instance.registerLazySingleton(
      () => CreatePostUseCase(repository: instance.call()));
  instance.registerLazySingleton(
      () => ReadPostsUseCase(repository: instance.call()));
  instance.registerLazySingleton(
      () => LikePostUseCase(repository: instance.call()));
  instance.registerLazySingleton(
      () => UpdatePostUseCase(repository: instance.call()));
  instance.registerLazySingleton(
      () => DeletePostUseCase(repository: instance.call()));
  instance.registerLazySingleton(
      () => ReadSinglePostUseCase(repository: instance.call()));
  instance.registerLazySingleton(
      () => UploadImagePostUseCase(repository: instance.call()));

  //++++++++++++++++++++++++++++++++++++  Comment ++++++++++++++++++++++++++++++++++++

  instance.registerLazySingleton(
      () => CreateCommentUseCase(repository: instance.call()));
  instance.registerLazySingleton(
      () => ReadCommentsUseCase(repository: instance.call()));
  instance.registerLazySingleton(
      () => LikeCommentUseCase(repository: instance.call()));
  instance.registerLazySingleton(
      () => UpdateCommentUseCase(repository: instance.call()));
  instance.registerLazySingleton(
      () => DeleteCommentUseCase(repository: instance.call()));

  //++++++++++++++++++++++++++++++++++++  Replay ++++++++++++++++++++++++++++++++++++

  instance.registerLazySingleton(
      () => CreateReplayUseCase(repository: instance.call()));
  instance.registerLazySingleton(
      () => ReadReplaysUseCase(repository: instance.call()));
  instance.registerLazySingleton(
      () => LikeReplayUseCase(repository: instance.call()));
  instance.registerLazySingleton(
      () => UpdateReplayUseCase(repository: instance.call()));
  instance.registerLazySingleton(
      () => DeleteReplayUseCase(repository: instance.call()));

  //++++++++++++++++++++++++++++++++++++  Chat ++++++++++++++++++++++++++++++++++++

  instance.registerLazySingleton(
      () => GetMessageUseCase(repository: instance.call()));
  instance.registerLazySingleton(
      () => SendMessageUseCase(repository: instance.call()));

  // -----------------------------Repository-----------------------

  instance.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(userRemoteDataSource: instance.call()),
  );
  instance.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(postRemoteDataSource: instance.call()),
  );
  instance.registerLazySingleton<CommentRepository>(
    () => CommentRepositoryImpl(remoteDataSource: instance.call()),
  );
  instance.registerLazySingleton<ReplayRepository>(
    () => ReplayRepositoryImpl(replayRemoteDataSource: instance.call()),
  );
  instance.registerLazySingleton<MessageRepository>(
    () => MessageRepositoryImpl(messageRemoteDataSource: instance.call()),
  );

  // -------------------------------- Remote Data Source
  instance.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(
            firebaseFirestore: instance.call(),
            firebaseAuth: instance.call(),
            firebaseStorage: instance.call(),
          ));
  instance.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(
            firebaseFirestore: instance.call(),
            firebaseAuth: instance.call(),
            firebaseStorage: instance.call(),
          ));
  instance.registerLazySingleton<CommentRemoteDataSource>(
      () => CommentRemoteDataSourceImpl(
            firebaseFirestore: instance.call(),
            firebaseAuth: instance.call(),
            firebaseStorage: instance.call(),
          ));
  instance.registerLazySingleton<ReplayRemoteDataSource>(
      () => ReplayRemoteDataSourceImpl(
            firebaseFirestore: instance.call(),
            firebaseAuth: instance.call(),
            firebaseStorage: instance.call(),
          ));
  instance.registerLazySingleton<MessageRemoteDataSource>(
      () => MessageRemoteDataSourceImpl(
            firebaseFirestore: instance.call(),
            firebaseAuth: instance.call(),
            firebaseStorage: instance.call(),
          ));
  //--------------------------- Externals-----------------------------------

  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;

  instance.registerLazySingleton(() => firebaseFirestore);
  instance.registerLazySingleton(() => firebaseAuth);
  instance.registerLazySingleton(() => firebaseStorage);
}
