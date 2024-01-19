// ignore_for_file: file_names

import 'package:all_in_one_admin/constant.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  AppButton(
      {super.key,
      required this.title,
      required this.fun,
      this.borderColor = cColor,
      this.shadowColor = Colors.black45});

  String title;
  Function() fun;
  Color borderColor;
  Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: borderColor, width: 5)),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              backgroundColor: Colors.white),
          onPressed: fun,
          child: Text(
            title,
            style: const TextStyle(
                color: pColor, fontWeight: FontWeight.bold, fontSize: 30),
          )),
    );
  }
}
