// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/features/Post/domain/usecases/upload_image_post_usecase.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../../app/di.dart' as di;
import '../../../../core/widgets/image_profile_widget.dart';
import '../../../user/domain/entities/user_entity.dart';
import '../../../user/presentation/profile/widgets/input_edit_profile_widget.dart';
import '../../domain/entities/post_entity.dart';
import '../cubit/post_cubit.dart';

class UploadPostMainWidget extends StatefulWidget {
  final UserEntity currentUser;
  const UploadPostMainWidget({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  @override
  State<UploadPostMainWidget> createState() => _UploadPostMainWidgetState();
}

class _UploadPostMainWidgetState extends State<UploadPostMainWidget> {
  File? _image;
  final TextEditingController _descriptionController = TextEditingController();
  bool _uploading = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
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
      debugPrint("some error occurs $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return _image == null
        ? _uploadPostWidget()
        : Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                  onTap: () => setState(() => _image = null),
                  child: const Icon(
                    Icons.close,
                    size: 28,
                  )),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: _submitPost,
                      child: const Icon(Icons.arrow_forward)),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(AppPadding.p10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: AppSize.s100,
                      height: AppSize.s100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.s50),
                        child: imageProfileWidget(
                            imageUrl: "${widget.currentUser.profileUrl}"),
                      ),
                    ),
                    AppConstants.sizeVer(AppSize.s10),
                    Text(
                      "${widget.currentUser.username}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    AppConstants.sizeVer(AppSize.s10),
                    SizedBox(
                      width: double.infinity,
                      height: AppSize.s200,
                      child: imageProfileWidget(image: _image),
                    ),
                    AppConstants.sizeVer(AppSize.s10),
                    InputEditProfileWidget(
                      textController: _descriptionController,
                      label: "Description",
                      isProfile: false,
                    ),
                    AppConstants.sizeVer(AppSize.s10),
                    _uploading == true
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Updating...",
                                style: TextStyle(color: Colors.white),
                              ),
                              AppConstants.sizeHor(AppSize.s10),
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

  _submitPost() {
    setState(() {
      _uploading = true;
    });
    di
        .instance<UploadImagePostUseCase>()
        .call(
          _image!,
        )
        .then((imageUrl) {
      _createSubmitPost(image: imageUrl);
    });
  }

  _createSubmitPost({required String image}) {
    BlocProvider.of<PostCubit>(context)
        .createPost(
            post: PostEntity(
                description: _descriptionController.text,
                createAt: Timestamp.now(),
                creatorUid: widget.currentUser.uid,
                likes: const [],
                postId: const Uuid().v1(),
                postImageUrl: image,
                totalComments: 0,
                totalLikes: 0,
                username: widget.currentUser.username,
                userProfileUrl: widget.currentUser.profileUrl))
        .then((value) => _clear());
  }

  _clear() {
    setState(() {
      _uploading = false;
      _descriptionController.clear();
      _image = null;
    });
  }

  _uploadPostWidget() {
    return Scaffold(
        body: Center(
      child: GestureDetector(
        onTap: selectImage,
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
              color: ColorManager.grey.withOpacity(.3), shape: BoxShape.circle),
          child: const Center(
            child: Icon(
              Icons.upload,
              color: ColorManager.white,
              size: 40,
            ),
          ),
        ),
      ),
    ));
  }
}
