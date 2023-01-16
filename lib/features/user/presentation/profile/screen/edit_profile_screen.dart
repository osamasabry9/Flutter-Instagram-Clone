// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/usecases/upload_image_profile_to_storage_usecase.dart';

import '../../../../../../core/utils/color_manager.dart';
import '../../../../../../core/utils/constants_manager.dart';
import '../../../../../../core/utils/values_manager.dart';
import '../../../../../core/widgets/image_profile_widget.dart';
import '../cubit/user_cubit.dart';
import '../widgets/input_edit_profile_widget.dart';
import '../../../../../app/di.dart' as di;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  final UserEntity currentUser;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _image;
  bool _isUpdating = false;
  TextEditingController? _nameController;
  TextEditingController? _usernameController;
  TextEditingController? _websiteController;
  TextEditingController? _bioController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.currentUser.name);
    _usernameController =
        TextEditingController(text: widget.currentUser.username);
    _websiteController =
        TextEditingController(text: widget.currentUser.website);
    _bioController = TextEditingController(text: widget.currentUser.bio);
    super.initState();
  }

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

  _updateUserProfileData() {
    setState(() => _isUpdating = true);
    if (_image == null) {
      _updateUserProfile("");
    } else {
      di
          .instance<UploadImageProfileToStorageUseCase>()
          .call(
            _image!,
          )
          .then((profileUrl) {
        _updateUserProfile(profileUrl);
      });
    }
  }

  _updateUserProfile(String profileUrl) {
    BlocProvider.of<UserCubit>(context)
        .updateUser(
            user: UserEntity(
                uid: widget.currentUser.uid,
                username: _usernameController!.text,
                bio: _bioController!.text,
                website: _websiteController!.text,
                name: _nameController!.text,
                profileUrl: profileUrl))
        .then((value) => _clear());
  }

  _clear() {
    setState(() {
      _isUpdating = false;
      _usernameController!.clear();
      _bioController!.clear();
      _websiteController!.clear();
      _nameController!.clear();
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.close,
              size: 32,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: _updateUserProfileData,
              child: const Icon(
                Icons.done,
                color: ColorManager.darkPrimary,
                size: 32,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: imageProfileWidget(
                        imageUrl: widget.currentUser.profileUrl, image: _image),
                  ),
                ),
              ),
              AppConstants.sizeVer(AppSize.s12),
              Center(
                child: GestureDetector(
                  onTap: selectImage,
                  child: const Text(
                    "Change profile photo",
                    style: TextStyle(
                        color: ColorManager.darkPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              AppConstants.sizeVer(AppSize.s12),
              InputEditProfileWidget(
                  label: "Name", textController: _nameController),
              AppConstants.sizeVer(AppSize.s12),
              InputEditProfileWidget(
                  label: "Username", textController: _usernameController),
              AppConstants.sizeVer(AppSize.s12),
              InputEditProfileWidget(
                  label: "Website", textController: _websiteController),
              AppConstants.sizeVer(AppSize.s12),
              InputEditProfileWidget(
                  label: "Bio", textController: _bioController),
              AppConstants.sizeVer(10),
              _isUpdating == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Please wait...",
                          style: TextStyle(color: Colors.white),
                        ),
                        AppConstants.sizeHor(10),
                        const CircularProgressIndicator()
                      ],
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}