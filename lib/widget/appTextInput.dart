// ignore_for_file: file_names

import 'package:all_in_one_admin/constant.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppTextInput extends StatelessWidget {
  AppTextInput(
      {super.key,
      required this.controller,
      required this.hint,
      required this.titleIcon,
      required this.type,
      required this.title});
  TextEditingController controller;
  String title;
  String hint;
  IconData titleIcon;
  TextInputType type;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(
              color: cColor,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              titleIcon,
              color: cColor,
            ),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: pColor, width: 5),
                borderRadius: BorderRadius.circular(25)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: cColor, width: 5),
                borderRadius: BorderRadius.circular(25)),
          ),
          keyboardType: type,
        ),
      ),
    );
  }
}
