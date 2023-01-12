import 'package:flutter/material.dart';


import '../widgets/app_bar_widget.dart';
import '../widgets/single_post_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      body: const SinglePostCardWidget(),
    );
  }
}

