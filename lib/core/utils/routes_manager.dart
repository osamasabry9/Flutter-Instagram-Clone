import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/Post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/presentation/auth/cubit/auth/auth_cubit.dart';

import '../../features/Comment/presentation/Screens/comment_screen.dart';
import '../../features/Post/presentation/screen/update_post_screen.dart';
import '../../features/Post/presentation/screen/upload_post_screen.dart';
import '../../features/user/presentation/auth/screens/login_screen.dart';
import '../../features/user/presentation/auth/screens/register_screen.dart';
import '../../features/user/presentation/profile/screen/edit_profile_screen.dart';
import '../../features/main_Screens/main_screen.dart';
import 'strings_manager.dart';

class Routes {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String mainRoute = '/main';
  static const String editProfileRoute = '/editProfile';
  static const String commentRoute = '/comment';
  static const String updatePostRoute = '/updatePost';
  static const String uploadPostRoute = '/uploadPost';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    var args = settings.arguments;

    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return MainScreen(
                    uid: authState.uid,
                  );
                } else {
                  return const LoginScreen();
                }
              },
            );
          },
        );
      case Routes.registerRoute:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      case Routes.mainRoute:
        return MaterialPageRoute(
          builder: (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return MainScreen(
                    uid: authState.uid,
                  );
                } else {
                  return const LoginScreen();
                }
              },
            );
          },
        );
      case Routes.editProfileRoute:
        {
          if (args is UserEntity) {
            return routeBuilder(EditProfileScreen(
              currentUser: args,
            ));
          } else {
            return routeBuilder(const NoFoundScreen());
          }
        }
      case Routes.uploadPostRoute:
        {
          if (args is UserEntity) {
            return routeBuilder(UploadPostScreen(
              currentUser: args,
            ));
          } else {
            return routeBuilder(const NoFoundScreen());
          }
        }

      case Routes.updatePostRoute:
        {
          if (args is PostEntity) {
            return routeBuilder(UpdatePostScreen(
              post: args,
            ));
          } else {
            return routeBuilder(const NoFoundScreen());
          }
        }
      case Routes.commentRoute:
        return MaterialPageRoute(
          builder: (_) => const CommentScreen(),
        );

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const NoFoundScreen(),
    );
  }
}

dynamic routeBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

class NoFoundScreen extends StatelessWidget {
  const NoFoundScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.noRouteFound,
        ),
      ),
      body: const Center(
        child: Text(
          AppStrings.noRouteFound,
        ),
      ),
    );
  }
}
