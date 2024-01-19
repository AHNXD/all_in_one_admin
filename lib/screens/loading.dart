// ignore_for_file: no_logic_in_create_state, use_build_context_synchronously

import 'package:all_in_one_admin/constant.dart';
import 'package:all_in_one_admin/screens/Home.dart';
import 'package:all_in_one_admin/services/apiService.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoadingScreen extends StatefulWidget {
  static String id = "/load";
  BuildContext context;
  LoadingScreen(this.context, {super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState(context);
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late final Animation<double> _scaleAnimation =
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  void next(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1000), () async {
      int res = await ApiService.adminLogin("admin", "123");
      if (res == 200) {
        Navigator.pop(context);
        Navigator.of(context).push(goRoute(x: const HomeScreen()));
        massege("Welcome Admin", Colors.green, context);
      } else {
        massege("There was an error, Check your connection and try again",
            Colors.red, context);
      }
    });
  }

  _LoadingScreenState(BuildContext context) {
    next(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pColor,
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Padding(
            padding: const EdgeInsets.all(60.0),
            child: Image.asset("assets/images/logo.png"),
          ),
        ),
      ),
    );
  }
}
