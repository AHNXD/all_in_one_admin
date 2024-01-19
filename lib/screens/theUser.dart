// ignore_for_file: file_names

import 'package:all_in_one_admin/constant.dart';
import 'package:all_in_one_admin/screens/history.dart';
import 'package:all_in_one_admin/services/apiService.dart';
import 'package:all_in_one_admin/widget/AppButton.dart';
import 'package:all_in_one_admin/widget/costLable.dart';
import 'package:flutter/material.dart';

class TheUser extends StatefulWidget {
  const TheUser({super.key});
  static String id = "/User";
  @override
  State<TheUser> createState() => _TheUserState();
}

class _TheUserState extends State<TheUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/logo.png",
          height: 55,
        ),
        backgroundColor: pColor,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ApiService.getUser(code: theStu),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            userData = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(children: [
                CustLable(
                  lead: "serial:",
                  tail: userData[0]["code"],
                  go: () {},
                ),
                CustLable(
                  lead: "Name:",
                  tail: userData[0]["name"],
                  go: () {},
                ),
                CustLable(
                  lead: "pass:",
                  tail: userData[0]["password"],
                  go: () {},
                ),
                CustLable(
                  lead: "Cash:",
                  tail: "${userData[0]["balance"]}",
                  go: () {},
                ),
                const Divider(
                  color: cColor,
                  thickness: 5,
                ),
                const Divider(
                  color: pColor,
                  thickness: 5,
                ),
                AppButton(
                  shadowColor: pColor,
                  title: "History",
                  fun: () {
                    Navigator.of(context)
                        .push(goRoute(x: const HistoryScreen()));
                  },
                ),
              ]),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: cColor,
                backgroundColor: pColor,
              ),
            );
          }
        },
      ),
    );
  }
}
