import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/chat/presentation/cubit/chat_cubit.dart';

import '../core/utils/routes_manager.dart';
import '../core/utils/theme_manager.dart';
import '../features/user/presentation/auth/cubit/auth/auth_cubit.dart';
import '../features/user/presentation/auth/cubit/credential/credential_cubit.dart';
import '../features/user/presentation/profile/cubit/get_single_other_user/get_single_other_user_cubit.dart';
import '../features/user/presentation/profile/cubit/get_single_user/get_single_user_cubit.dart';
import '../features/user/presentation/profile/cubit/user_cubit.dart';
import 'di.dart' as di;

class MyApp extends StatefulWidget {
  const MyApp._internal();
  static const MyApp _instance = MyApp._internal();
  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => di.instance<AuthCubit>()..appStarted(context)),
        BlocProvider(create: (_) => di.instance<CredentialCubit>()),
        BlocProvider(create: (_) => di.instance<UserCubit>()),
        BlocProvider(create: (_) => di.instance<GetSingleUserCubit>()),
        BlocProvider(create: (_) => di.instance<GetSingleOtherUserCubit>()),
        BlocProvider(
          create: (_) => di.instance<ChatCubit>(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.loginRoute,
      ),
    );
  }
}
