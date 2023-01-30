import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/constants_manager.dart';

import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/routes_manager.dart';
import '../../../../../core/utils/values_manager.dart';
import '../../../../../core/widgets/input_field.dart';
import '../../../../../core/widgets/main_button.dart';
import '../../../../main_Screens/main_screen.dart';
import '../cubit/auth/auth_cubit.dart';
import '../cubit/credential/credential_cubit.dart';
import '../widgets/logo_widget.dart';
import '../widgets/text_navigator_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  var loginFromKey = GlobalKey<FormState>();
  bool _isSigningIn = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<CredentialCubit, CredentialState>(
      listener: (context, credentialState) {
        if (credentialState is CredentialSuccess) {
          BlocProvider.of<AuthCubit>(context).loggedIn();
        }
        if (credentialState is CredentialFailure) {
          AppConstants.toast("Invalid Email and Password");
        }
      },
      builder: (context, credentialState) {
        if (credentialState is CredentialSuccess) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              if (authState is Authenticated) {
                return MainScreen(uid: authState.uid);
              } else {
                return _bodyWidget(context);
              }
            },
          );
        }
        return _bodyWidget(context);
      },
    ));
  }

  Widget _bodyWidget(BuildContext context) {
    return Center(
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
                        textController: _emailController,
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
                        textController: _passwordController,
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
                        onTap: _signInUser,
                        title: ' Sign in',
                      ),
                      AppConstants.sizeVer(10),
                      _isSigningIn == true
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Please wait",
                                  style: TextStyle(
                                      color: ColorManager.primary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                AppConstants.sizeHor(10),
                                const CircularProgressIndicator(
                                  color: ColorManager.primary,
                                )
                              ],
                            )
                          : const SizedBox(
                              width: 0,
                              height: 0,
                            ),
                      if (_isSigningIn == false)
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
    );
  }

  void _signInUser() {
    setState(() {
      _isSigningIn = true;
    });
    BlocProvider.of<CredentialCubit>(context)
        .signInUser(
          email: _emailController.text,
          password: _passwordController.text,
        )
        .then((value) => _clear());
  }

  _clear() {
    setState(() {
      _emailController.clear();
      _passwordController.clear();
      _isSigningIn = false;
    });
  }
}
