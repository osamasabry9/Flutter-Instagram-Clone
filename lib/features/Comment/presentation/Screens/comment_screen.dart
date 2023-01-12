import 'package:flutter/material.dart';

import '../widgets/comment_main_widget.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
      ),
      body: const CommentMainWidget(),
    );
  }
}
