// ignore_for_file: use_build_context_synchronously, file_names
import 'package:all_in_one_admin/constant.dart';
import 'package:all_in_one_admin/services/apiService.dart';
import 'package:all_in_one_admin/widget/appBarLogo.dart';
import 'package:all_in_one_admin/widget/appTextInput.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});
  static String id = "/Add";

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  ScrollController scrollController = ScrollController();
  bool _isloading = false;
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
        onPressed: () async {
          _isloading = true;
          setState(() {});
          try {
            int res = await ApiService.register(
                code: AddSerial.text,
                name: AddName.text,
                pass: AddPass.text,
                amount: AddPrice.text);
            if (res == 200) {
              massege("User added", Colors.green, context);
            } else if (res == 500) {
              massege("The ID is taken", Colors.red, context);
            } else {
              massege("Check your connection", Colors.red, context);
            }
          } catch (e) {
            massege("There was an Error", Colors.red, context);
          }
          AddName.text = "";
          AddPass.text = "";
          AddPrice.text = "";
          AddSerial.text = "";
          _isloading = false;
          setState(() {});
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
          "Add User",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: pColor),
        ),
      ),
      body: _isloading
          ? const Center(
              child: CircularProgressIndicator(
                color: cColor,
                backgroundColor: pColor,
              ),
            )
          : Container(
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
                      controller: AddSerial,
                      hint: "Enter the Serial",
                      titleIcon: Icons.format_list_numbered_sharp,
                      type: TextInputType.number,
                      title: ""),
                  AppTextInput(
                      controller: AddName,
                      hint: "Enter the Name",
                      titleIcon: Icons.person,
                      type: TextInputType.text,
                      title: ""),
                  AppTextInput(
                      controller: AddPass,
                      hint: "Enter the Password",
                      titleIcon: Icons.password,
                      type: TextInputType.text,
                      title: ""),
                  AppTextInput(
                      controller: AddPrice,
                      hint: "Enter the Price",
                      titleIcon: Icons.attach_money,
                      type: TextInputType.number,
                      title: ""),
                ],
              ))),
    );
  }
}
