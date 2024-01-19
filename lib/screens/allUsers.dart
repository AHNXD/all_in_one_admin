// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, avoid_types_as_parameter_names, file_names

import 'package:all_in_one_admin/constant.dart';
import 'package:all_in_one_admin/screens/theUser.dart';
import 'package:all_in_one_admin/services/apiService.dart';
import 'package:flutter/material.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({super.key});
  static String id = "/All";
  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  bool act = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  act = act ? false : true;
                  setState(() {});
                },
                icon: const Icon(Icons.cancel))
          ],
          title: Image.asset(
            "assets/images/logo.png",
            height: 55,
          ),
          backgroundColor: pColor,
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: ApiService.getUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              allStu = snapshot.data;
              return Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: ListView.builder(
                    itemCount: allStu.length,
                    itemBuilder: (BuildContext, index) {
                      return allStu[index]["isActive"] == act
                          ? Padding(
                              padding: const EdgeInsets.all(16),
                              child: GestureDetector(
                                onTap: () {
                                  theStu = allStu[index]["code"];
                                  Navigator.of(context)
                                      .push(goRoute(x: const TheUser()));
                                },
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: cColor,
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              0), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(60),
                                      border:
                                          Border.all(color: pColor, width: 5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: cColor, width: 5),
                                              shape: BoxShape.circle),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              allStu[index]["code"],
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          child: Text(
                                            "${allStu[index]["name"]}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (context) => AlertDialog(
                                                            title: Text(
                                                              act
                                                                  ? "Do you want to delete this User ?"
                                                                  : "Do you want to retrieve this User ?",
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 35),
                                                            ),
                                                            actions: [
                                                              ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  if (act) {
                                                                    await ApiService.deactivate(
                                                                        code: allStu[index]
                                                                            [
                                                                            "code"]);
                                                                  } else {
                                                                    await ApiService.Activate(
                                                                        code: allStu[index]
                                                                            [
                                                                            "code"]);
                                                                  }
                                                                  Navigator.pop(
                                                                      context);
                                                                  setState(
                                                                      () {});
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .green,
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            20),
                                                                    elevation:
                                                                        20,
                                                                    shape: const RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(20)))),
                                                                child:
                                                                    const Text(
                                                                        "Yes"),
                                                              ),
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            20),
                                                                    elevation:
                                                                        20,
                                                                    shape: const RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(20)))),
                                                                child:
                                                                    const Text(
                                                                        "No"),
                                                              )
                                                            ],
                                                            backgroundColor:
                                                                pColor,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                          ));
                                            },
                                            icon: Icon(
                                              act ? Icons.delete : Icons.check,
                                              color: act
                                                  ? Colors.red
                                                  : Colors.green,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container();
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
        ));
  }
}
