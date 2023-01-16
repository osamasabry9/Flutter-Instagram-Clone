// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/core/utils/constants_manager.dart';

import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/routes_manager.dart';
import '../../../../../core/utils/values_manager.dart';
import '../../../../../core/widgets/image_profile_widget.dart';
import '../../../../../core/widgets/input_field.dart';
import '../../../../../core/widgets/main_button.dart';
import '../../../../main_Screens/main_screen.dart';
import '../../../domain/entities/user_entity.dart';
import '../cubit/auth/auth_cubit.dart';
import '../cubit/credential/credential_cubit.dart';
import '../widgets/logo_widget.dart';
import '../widgets/text_navigator_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _bioController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  var registerFromKey = GlobalKey<FormState>();

  final TextEditingController _userNameController = TextEditingController();
  bool _isSigningUp = false;
  final bool _isUploading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  File? _image;

  Future selectImage() async {
    try {
      final pickedFile =
          await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          debugPrint("no image has been selected");
        }
      });
    } catch (e) {
      AppConstants.toast("some error occurred $e");
    }
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
        )
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return SingleChildScrollView(
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
                    uploadedImageProfileWidget(),
                    InputField(
                      textController: _userNameController,
                      label: " User Name",
                      hint: "Enter  User Name",
                      prefix: Icons.person,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'User name  must be filled';
                        }
                        return null;
                      },
                    ),
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
                    InputField(
                      textController: _bioController,
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
                      onTap: () {
                        _signUpUser();
                      },
                      title: ' Sign Up',
                    ),
                    AppConstants.sizeVer(10),
                    _isSigningUp == true || _isUploading == true
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
    );
  }

  Widget uploadedImageProfileWidget() {
    return Center(
      child: Stack(
        children: [
          SizedBox(
            width: AppSize.s70,
            height: AppSize.s70,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: imageProfileWidget(image: _image),
            ),
          ),
          Positioned(
            right: -10,
            bottom: -15,
            child: IconButton(
              onPressed: selectImage,
              icon: const Icon(
                Icons.add_a_photo,
                color: ColorManager.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signUpUser() async {
    setState(() {
      _isSigningUp = true;
    });
    BlocProvider.of<CredentialCubit>(context)
        .signUpUser(
            user: UserEntity(
                email: _emailController.text,
                password: _passwordController.text,
                bio: _bioController.text,
                username: _userNameController.text,
                totalPosts: 0,
                totalFollowing: 0,
                followers: const [],
                totalFollowers: 0,
                website: "",
                following: const [],
                name: "",
                imageFile: _image))
        .then((value) => _clear());
  }

  _clear() {
    setState(() {
      _userNameController.clear();
      _bioController.clear();
      _emailController.clear();
      _passwordController.clear();
      _isSigningUp = false;
    });
  }
}
