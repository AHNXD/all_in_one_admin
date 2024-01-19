// ignore_for_file: file_names

import 'package:all_in_one_admin/constant.dart';
import 'package:all_in_one_admin/screens/CamScanner.dart';
import 'package:all_in_one_admin/screens/addUser.dart';
import 'package:all_in_one_admin/screens/allUsers.dart';
import 'package:all_in_one_admin/screens/offers.dart';
import 'package:all_in_one_admin/widget/AppButton.dart';
import 'package:all_in_one_admin/widget/appBarLogo.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String id = "/Home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    setState(() {});
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: cColor,
          onPressed: () {
            Navigator.of(context).push(goRoute(x: const CamScanner()));
          },
          child: const Icon(
            Icons.qr_code,
            color: Colors.black,
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            "All In One",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: pColor),
          ),
        ),
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg2.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
                child: Column(
              children: [
                AppBarLogo(animationController: animationController),
                const Spacer(
                  flex: 1,
                ),
                AppButton(
                    title: "All Users",
                    fun: () {
                      Navigator.of(context).push(goRoute(x: const AllUsers()));
                    }),
                const Spacer(
                  flex: 1,
                ),
                AppButton(
                  title: "Add User",
                  fun: () {
                    Navigator.of(context).push(goRoute(x: const AddUser()));
                  },
                ),
                const Spacer(
                  flex: 1,
                ),
                AppButton(
                    title: "Offers",
                    fun: () {
                      Navigator.of(context)
                          .push(goRoute(x: const OffersScreen()));
                    }),
                const Spacer(
                  flex: 1,
                ),
              ],
            ))));
  }
}
