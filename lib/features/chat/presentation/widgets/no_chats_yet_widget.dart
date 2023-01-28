import 'package:flutter/material.dart';


class NoChatsYetWidget extends StatelessWidget {
  const NoChatsYetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "No Chats Yet",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}