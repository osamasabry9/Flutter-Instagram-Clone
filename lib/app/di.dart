import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

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
import '../features/user/presentation/auth/cubit/auth/auth_cubit.dart';
import '../features/user/presentation/auth/cubit/credential/credential_cubit.dart';
import '../features/user/presentation/profile/cubit/get_single_other_user/get_single_other_user_cubit.dart';
import '../features/user/presentation/profile/cubit/get_single_user/get_single_user_cubit.dart';
import '../features/user/presentation/profile/cubit/user_cubit.dart';

final instance = GetIt.instance;

Future<void> init() async {
// ------------------------Cubits-----------------------------
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
    () => GetSingleUserCubit(getSingleUserUseCase: instance.call()),
  );

  instance.registerFactory(
    () => GetSingleOtherUserCubit(getSingleOtherUserUseCase: instance.call()),
  );

  // --------------------------Use Cases--------------------
  // User
  instance.registerLazySingleton(
    () => SignOutUseCase(repository: instance.call()),
  );
  instance.registerLazySingleton(
    () => IsSignInUseCase(repository: instance.call()),
  );
  instance.registerLazySingleton(
    () => GetCurrentUidUseCase(repository: instance.call()),
  );
  instance.registerLazySingleton(
    () => SignUpUseCase(repository: instance.call()),
  );
  instance.registerLazySingleton(
    () => SignInUserUseCase(repository: instance.call()),
  );
  instance.registerLazySingleton(
    () => UpdateUserUseCase(repository: instance.call()),
  );
  instance.registerLazySingleton(
    () => GetUsersUseCase(repository: instance.call()),
  );
  instance.registerLazySingleton(
    () => CreateUserUseCase(repository: instance.call()),
  );
  instance.registerLazySingleton(
    () => GetSingleUserUseCase(repository: instance.call()),
  );
  instance.registerLazySingleton(
    () => FollowUnFollowUseCase(repository: instance.call()),
  );
  instance.registerLazySingleton(
    () => GetSingleOtherUserUseCase(
      repository: instance.call(),
    ),
  );

  // Repository

  instance.registerLazySingleton<UserFirebaseRepository>(
    () => UserFirebaseRepositoryImpl(userRemoteDataSource: instance.call()),
  );

  // Remote Data Source
  instance.registerLazySingleton<UserFirebaseRemoteDataSource>(
      () => UserFirebaseRemoteDataSourceImpl(
            firebaseFirestore: instance.call(),
            firebaseAuth: instance.call(),
            firebaseStorage: instance.call(),
          ));

  // Externals

  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;

  instance.registerLazySingleton(() => firebaseFirestore);
  instance.registerLazySingleton(() => firebaseAuth);
  instance.registerLazySingleton(() => firebaseStorage);
}
