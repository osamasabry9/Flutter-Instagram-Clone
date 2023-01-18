import 'package:flutter/material.dart';


class NoPostsYetWidget extends StatelessWidget {
  const NoPostsYetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "No Posts Yet",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}