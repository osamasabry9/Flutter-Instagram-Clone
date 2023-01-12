import 'package:flutter/material.dart';
import 'package:instagram_clone/features/Comment/presentation/page/comment_page.dart';
import 'package:instagram_clone/features/auth/presentation/page/login_screen.dart';
import 'package:instagram_clone/features/auth/presentation/page/register_screen.dart';
import 'package:instagram_clone/features/profile/presentation/screen/edit_profile_page.dart';

import '../../features/Post/presentation/screen/update_post_page.dart';
import '../../features/main_pages/main_screen.dart';
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
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
   // final args = settings.arguments;

    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case Routes.registerRoute:
        return MaterialPageRoute(
          builder: (_) => RegisterScreen(),
        );
      case Routes.mainRoute:
        return MaterialPageRoute(
          builder: (_) => const MainScreen(),
        );
      case Routes.editProfileRoute:
        return MaterialPageRoute(
          builder: (_) => const EditProfilePage(),
        );
      case Routes.commentRoute:
        return MaterialPageRoute(
          builder: (_) => const CommentPage(),
        );
      case Routes.updatePostRoute:
        return MaterialPageRoute(
          builder: (_) => const UpdatePostPage(),
        );

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
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
      ),
    );
  }
}
