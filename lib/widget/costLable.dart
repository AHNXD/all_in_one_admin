// ignore_for_file: file_names

import 'package:all_in_one_admin/constant.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustLable extends StatelessWidget {
  CustLable(
      {required this.lead, required this.tail, required this.go, super.key});
  String lead;
  String tail;
  Function() go;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          padding: const EdgeInsets.all(16),
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              border: Border.all(color: pColor, width: 5)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    lead,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    tail,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: go,
                      icon: const Icon(
                        Icons.edit,
                        color: cColor,
                      ))
                ]),
          )),
    );
  }
}
