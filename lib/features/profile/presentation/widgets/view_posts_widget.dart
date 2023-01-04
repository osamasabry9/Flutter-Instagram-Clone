import 'package:flutter/material.dart';
import '../../../auth/presentation/widgets/profile_widget.dart';

class ViewPostsWidget extends StatelessWidget {
  const ViewPostsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
                itemCount: 5,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: profileWidget(imageUrl: ''),
                    ),
                  );
                },
              );
  }
}