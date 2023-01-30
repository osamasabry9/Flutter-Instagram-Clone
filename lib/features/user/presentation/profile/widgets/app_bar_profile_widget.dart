import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../../../../core/utils/routes_manager.dart';
import '../../../../../../../core/utils/values_manager.dart';
import '../../../../../../core/utils/color_manager.dart';
import '../../../../../../core/utils/constants_manager.dart';
import '../../auth/cubit/auth/auth_cubit.dart';
import '../screen/edit_profile_screen.dart';

AppBar appBarProfileWidget(BuildContext context, UserEntity currentUser ,{bool isYourProfile = false}) {
  return AppBar(
    automaticallyImplyLeading: isYourProfile,
    title: Text(currentUser.username.toString()),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: AppPadding.p12),
        child: InkWell(
          onTap: () {
            _openBottomModalSheet(context, currentUser);
          },
          child: const Icon(
            Icons.menu,
          ),
        ),
      )
    ],
  );
}

_openBottomModalSheet(BuildContext context, UserEntity currentUser) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 150,
          decoration:
              BoxDecoration(color: ColorManager.darkGrey.withOpacity(.8)),
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "More Options",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: ColorManager.white),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(
                    thickness: 1,
                    color: ColorManager.black,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                                context,
                                routeBuilder(EditProfileScreen(
                                    currentUser: currentUser)))
                            .then((value) => Navigator.pop(context));
                      },
                      child: const Text(
                        "Edit Profile",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: ColorManager.white),
                      ),
                    ),
                  ),
                  AppConstants.sizeVer(AppSize.s8),
                  const Divider(
                    thickness: 1,
                    color: ColorManager.black,
                  ),
                  AppConstants.sizeVer(AppSize.s8),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<AuthCubit>(context).loggedOut();
                        Navigator.pushNamedAndRemoveUntil(
                            context, Routes.loginRoute, (route) => false);
                      },
                      child: const Text(
                        "Log Out",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: ColorManager.white),
                      ),
                    ),
                  ),
                  AppConstants.sizeVer(AppSize.s8),
                ],
              ),
            ),
          ),
        );
      });
}
