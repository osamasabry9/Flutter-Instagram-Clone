// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/features/Post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/Post/domain/usecases/upload_image_post_usecase.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/constants_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../../../../../app/di.dart' as di;
import '../../../../core/widgets/image_profile_widget.dart';
import '../../../user/presentation/profile/widgets/input_edit_profile_widget.dart';
import '../cubit/post_cubit.dart';

class UpdatePostMainWidget extends StatefulWidget {
   final PostEntity post;
  const UpdatePostMainWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<UpdatePostMainWidget> createState() => _UpdatePostMainWidgetState();
}

class _UpdatePostMainWidgetState extends State<UpdatePostMainWidget> {
  TextEditingController? _descriptionController;

  @override
  void initState() {
    _descriptionController = TextEditingController(text: widget.post.description);
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController!.dispose();
    super.dispose();
  }

  File? _image;
  bool? _uploading = false;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Post"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppPadding.p10),
            child: GestureDetector(
                onTap: _updatePost,
                child: const Icon(
                  Icons.done,
                  color: ColorManager.primary,
                  size: 28,
                )),
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
                  child: imageProfileWidget(imageUrl: widget.post.userProfileUrl),
                ),
              ),
              AppConstants.sizeVer(AppSize.s10),
              Text(
                "${widget.post.username}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              AppConstants.sizeVer(AppSize.s10),
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: AppSize.s200,
                    child: imageProfileWidget(imageUrl: widget.post.postImageUrl, image: _image),
                  ),
                  Positioned(
                    top: AppSize.s16,
                    right: AppSize.s16,
                    child: GestureDetector(
                      onTap: selectImage,
                      child: Container(
                        width: AppSize.s32,
                        height: AppSize.s32,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              AppSize.s16,
                            )),
                        child: const Icon(
                          Icons.edit,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              AppConstants.sizeVer(AppSize.s10),
              InputEditProfileWidget(
                textController: _descriptionController!,
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

 _updatePost() {
    setState(() {
      _uploading = true;
    });
    if (_image == null) {
      _submitUpdatePost(image: widget.post.postImageUrl!);
    } else {
      di.instance<UploadImagePostUseCase>().call(_image!).then((imageUrl) {
        _submitUpdatePost(image: imageUrl);
      });
    }
  }


  _submitUpdatePost({required String image}) {
    BlocProvider.of<PostCubit>(context).updatePost(
        post: PostEntity(
            creatorUid: widget.post.creatorUid,
            postId: widget.post.postId,
            postImageUrl: image,
            description: _descriptionController!.text
        )
    ).then((value) => _clear());
  }

  _clear() {
    setState(() {
      _descriptionController!.clear();
      Navigator.pop(context);
      _uploading = false;
    });
  }

}
