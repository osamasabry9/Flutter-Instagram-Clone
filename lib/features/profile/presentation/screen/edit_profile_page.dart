import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/core/utils/color_manager.dart';

import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../auth/presentation/widgets/profile_widget.dart';
import '../widgets/input_edit_profile_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _websiteController;
  late TextEditingController _bioController;

  final bool _isUpdating = false;

  File? _image;
  @override
  void initState() {
    _nameController = TextEditingController(text: " ");
    _usernameController = TextEditingController(text: " ");
    _websiteController = TextEditingController(text: " ");
    _bioController = TextEditingController(text: " ");
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
      debugPrint("some error ${e.toString()}");
    }
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
                    child: profileWidget(imageUrl: "", image: _image),
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
                textController: _nameController,
                label: "Name",
              ),
              AppConstants.sizeVer(AppSize.s12),
              InputEditProfileWidget(
                textController: _usernameController,
                label: "User name",
              ),
              AppConstants.sizeVer(AppSize.s12),
              InputEditProfileWidget(
                textController: _websiteController,
                label: "Web site",
              ),
              AppConstants.sizeVer(AppSize.s12),
              InputEditProfileWidget(
                textController: _bioController,
                label: "Bio",
              ),
              AppConstants.sizeVer(AppSize.s8),
              _isUpdating == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Please wait...",
                          style: TextStyle(color: Colors.white),
                        ),
                        AppConstants.sizeHor(AppSize.s12),
                        const CircularProgressIndicator()
                      ],
                    )
                  : const SizedBox(
                      width: 0,
                      height: 0,
                    )
            ],
          ),
        ),
      ),
    );
  }

  _updateUserProfileData() {}

}

