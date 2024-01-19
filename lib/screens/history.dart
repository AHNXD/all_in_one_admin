// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:all_in_one_admin/constant.dart';
import 'package:all_in_one_admin/services/apiService.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});
  static String id = "/History";
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: userData[0]["payments"].length,
                  itemBuilder: (BuildContext, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: cColor,
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(60),
                              border: Border.all(color: pColor, width: 5)),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: cColor, width: 5),
                                      shape: BoxShape.circle),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${userData[0]["payments"].length - index}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      userData[0]["payments"][index]
                                          ["paymentDate"],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${userData[0]["payments"][index]["amount"]}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: userData[0]["payments"][index]
                                                      ["amount"] >=
                                                  0
                                              ? Colors.green
                                              : Colors.red),
                                    ),
                                    Text(
                                      "${userData[0]["payments"][index]["notes"]}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                              ]))),
                    );
                  }),
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
