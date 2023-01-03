import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/color_manager.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/input_field.dart';
import '../../../../core/widgets/main_button.dart';
import '../widgets/logo_widget.dart';
import '../widgets/text_navigator_widget.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  TextEditingController bioController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var registerFromKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: registerFromKey,
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p20),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      const LogoWidget(),
                      Center(
                        child: Stack(
                          children: [
                            SizedBox(
                              width: AppSize.s70,
                              height: AppSize.s70,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  ImageAssets.profileDefault,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: -10,
                              bottom: -15,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.add_a_photo,
                                  color: ColorManager.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InputField(
                        textController: userNameController,
                        label: "Your Name",
                        hint: "Enter Your Name",
                        prefix: Icons.person,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Your name  must be filled';
                          }
                          return null;
                        },
                      ),
                      InputField(
                        textController: emailController,
                        label: "Your email",
                        hint: "Enter Your email",
                        prefix: Icons.person,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return ' Email Address must be filled';
                          }
                          return null;
                        },
                      ),
                      InputField(
                        textController: passwordController,
                        label: "Password",
                        hint: "Enter password",
                        isPassword: true,
                        prefix: Icons.lock,
                        suffix: Icons.remove_red_eye_outlined,
                        suffixPressed: () {},
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Password must be filled';
                          }
                          return null;
                        },
                      ),
                      InputField(
                        textController: bioController,
                        label: "Bio",
                        hint: "Enter bio",
                        isPassword: false,
                        prefix: Icons.pending,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Bio must be filled';
                          }
                          return null;
                        },
                      ),
                      MainButton(
                        onTap: () {},
                        title: ' Sign Up',
                      ),
                      TextNavigatorWidget(
                        titleOne: "Already have an account? ",
                        titleTwo: 'Sign in',
                        mainAxisAlignment: MainAxisAlignment.center,
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.loginRoute);
                        },
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
