import 'package:flutter/material.dart';

import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../core/widgets/input_field.dart';
import '../../../../core/widgets/main_button.dart';
import '../widgets/logo_widget.dart';
import '../widgets/text_navigator_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  var loginFromKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Form(
                  key: loginFromKey,
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p20),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        const LogoWidget(),
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
                        const SizedBox(height: AppSize.s20),
                        TextNavigatorWidget(
                          titleOne: "Forget your Password ?",
                          titleTwo: '',
                          mainAxisAlignment: MainAxisAlignment.end,
                          onTap: () {},
                        ),
                        MainButton(
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
                          },
                          title: ' Sign in',
                        ),
                        TextNavigatorWidget(
                          titleOne: "Don't have account? ",
                          titleTwo: 'Sign Up',
                          mainAxisAlignment: MainAxisAlignment.center,
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.registerRoute);
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
      ),
    );
  }
}
