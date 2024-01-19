// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AppBarLogo extends StatelessWidget {
  const AppBarLogo({
    super.key,
    required this.animationController,
  });

  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0).animate(animationController),
            child: Image.asset(
              "assets/images/logo.png",
              height: 100,
            ),
          ),
        ));
  }
}
