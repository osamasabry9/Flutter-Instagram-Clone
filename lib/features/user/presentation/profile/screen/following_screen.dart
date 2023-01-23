import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/color_manager.dart';
import 'package:instagram_clone/core/utils/constants_manager.dart';
import '../../../../../app/di.dart' as di;
import '../../../../../core/utils/routes_manager.dart';
import '../../../../../core/widgets/image_profile_widget.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/get_single_user_usecase.dart';

class FollowingScreen extends StatelessWidget {
  final UserEntity user;
  const FollowingScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Following"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: user.following!.isEmpty
                  ? _noFollowersWidget()
                  : ListView.builder(
                      itemCount: user.following!.length,
                      itemBuilder: (context, index) {
                        return StreamBuilder<List<UserEntity>>(
                            stream: di
                                .instance<GetSingleUserUseCase>()
                                .call(user.following![index]),
                            builder: (context, snapshot) {
                              if (snapshot.hasData == false) {
                                return const CircularProgressIndicator();
                              }
                              if (snapshot.data!.isEmpty) {
                                return Container();
                              }
                              final singleUserData = snapshot.data!.first;
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.singleUserProfileRoute,
                                      arguments: singleUserData.uid);
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      width: 40,
                                      height: 40,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: imageProfileWidget(
                                            imageUrl:
                                                singleUserData.profileUrl),
                                      ),
                                    ),
                                    AppConstants.sizeHor(10),
                                    Text(
                                      "${singleUserData.username}",
                                      style: const TextStyle(
                                          color: ColorManager.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              );
                            });
                      }),
            )
          ],
        ),
      ),
    );
  }

  _noFollowersWidget() {
    return const Center(
      child: Text(
        "No Following",
        style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}
