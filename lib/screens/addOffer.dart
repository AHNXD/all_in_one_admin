// ignore_for_file: file_names

import 'package:all_in_one_admin/constant.dart';
import 'package:all_in_one_admin/widget/appBarLogo.dart';
import 'package:all_in_one_admin/widget/appTextInput.dart';
import 'package:flutter/material.dart';

class AddOfferScreen extends StatefulWidget {
  const AddOfferScreen({super.key});
  static String id = "/AddOffer";

  @override
  State<AddOfferScreen> createState() => _AddOfferScreenState();
}

class _AddOfferScreenState extends State<AddOfferScreen>
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
            offers.add({
              "title": offerT.text,
              "tName": offerTN.text,
              "price": offerP.text,
              "note": offerN.text
            });

            offerT.text = "";
            offerTN.text = "";
            offerP.text = "";
            offerN.text = "";
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: pColor,
                size: 30,
              )),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            "Add Offer",
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
                child: ListView(
              children: [
                AppBarLogo(animationController: animationController),
                const SizedBox(
                  height: 80,
                ),
                AppTextInput(
                  controller: offerT,
                  title: "",
                  hint: "Offer Title",
                  titleIcon: Icons.abc,
                  type: TextInputType.text,
                ),
                AppTextInput(
                  controller: offerTN,
                  title: "",
                  hint: "Teacher Name",
                  titleIcon: Icons.person,
                  type: TextInputType.text,
                ),
                AppTextInput(
                  controller: offerN,
                  title: "",
                  hint: "Note",
                  titleIcon: Icons.note,
                  type: TextInputType.text,
                ),
                AppTextInput(
                  controller: offerP,
                  title: "",
                  hint: "The Price",
                  titleIcon: Icons.attach_money,
                  type: TextInputType.number,
                ),
              ],
            ))));
  }
}
