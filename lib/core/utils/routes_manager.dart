import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/Post/domain/entities/post_entity.dart';
import '../../features/Post/presentation/screen/post_detail_screen.dart';
import '../../features/chat/presentation/pages/chat_screen.dart';
import '../../features/user/domain/entities/user_entity.dart';
import '../../features/user/presentation/auth/cubit/auth/auth_cubit.dart';
import '../../features/user/presentation/profile/screen/followers_screen.dart';

import '../../app/app_entity.dart';
import '../../features/Comment/domain/entities/comment_entity.dart';
import '../../features/Comment/presentation/Screens/comment_screen.dart';
import '../../features/Comment/presentation/Screens/edit_comment_screen.dart';
import '../../features/Post/presentation/screen/update_post_screen.dart';
import '../../features/Post/presentation/screen/upload_post_screen.dart';
import '../../features/replay/domain/entities/replay_entity.dart';
import '../../features/replay/presentation/pages/edit_replay_screen.dart';
import '../../features/stroy/presentation/pages/story_screen.dart';
import '../../features/user/presentation/auth/screens/login_screen.dart';
import '../../features/user/presentation/auth/screens/register_screen.dart';
import '../../features/user/presentation/profile/screen/edit_profile_screen.dart';
import '../../features/main_Screens/main_screen.dart';
import '../../features/user/presentation/profile/screen/following_screen.dart';
import '../../features/user/presentation/profile/screen/single_user_profile_screen.dart';
import 'strings_manager.dart';

class Routes {
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String mainRoute = '/main';
  static const String editProfileRoute = '/editProfile';
  static const String singleUserProfileRoute = '/singleUserProfileRoute';
  static const String followersRoute = '/followers';
  static const String followingRoute = '/followingRoute';
  static const String commentRoute = '/comment';
  static const String uploadCommentRoute = '/uploadComment';
  static const String updateReplayRoute = '/updateReplay';
  static const String updatePostRoute = '/updatePost';
  static const String uploadPostRoute = '/uploadPost';
  static const String postDetailRoute = '/postDetail';
  static const String chatRoute = '/chat';
  static const String storyRoute = '/story';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    var args = settings.arguments;

    switch (settings.name) {
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
        return routeBuilder(
          const RegisterScreen(),
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
      case Routes.singleUserProfileRoute:
        {
          if (args is String) {
            return routeBuilder(SingleUserProfileScreen(
              otherUserId: args,
            ));
          } else {
            return routeBuilder(const NoFoundScreen());
          }
        }
      case Routes.followersRoute:
        {
          if (args is UserEntity) {
            return routeBuilder(FollowersScreen(
              user: args,
            ));
          } else {
            return routeBuilder(const NoFoundScreen());
          }
        }
      case Routes.followingRoute:
        {
          if (args is UserEntity) {
            return routeBuilder(FollowingScreen(
              user: args,
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
      case Routes.postDetailRoute:
        {
          if (args is String) {
            return routeBuilder(PostDetailScreen(
              postId: args,
            ));
          } else {
            return routeBuilder(const NoFoundScreen());
          }
        }
      case Routes.commentRoute:
        {
          if (args is AppEntity) {
            return routeBuilder(CommentScreen(
              appEntity: args,
            ));
          }
          return routeBuilder(const NoFoundScreen());
        }
      case Routes.uploadCommentRoute:
        {
          if (args is CommentEntity) {
            return routeBuilder(EditCommentScreen(
              comment: args,
            ));
          }
          return routeBuilder(const NoFoundScreen());
        }
      case Routes.updateReplayRoute:
        {
          if (args is ReplayEntity) {
            return routeBuilder(EditReplayScreen(
              replay: args,
            ));
          }
          return routeBuilder(const NoFoundScreen());
        }
         case Routes.chatRoute:
        {
          return routeBuilder(const ChatScreen());
        }
           case Routes.storyRoute:
        {
          return routeBuilder(const StoryScreen());
        }

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
