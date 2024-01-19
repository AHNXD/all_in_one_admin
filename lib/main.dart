import 'package:all_in_one_admin/screens/CamScanner.dart';
import 'package:all_in_one_admin/screens/Home.dart';
import 'package:all_in_one_admin/screens/addOffer.dart';
import 'package:all_in_one_admin/screens/addUser.dart';
import 'package:all_in_one_admin/screens/allUsers.dart';
import 'package:all_in_one_admin/screens/history.dart';
import 'package:all_in_one_admin/screens/loading.dart';
import 'package:all_in_one_admin/screens/offers.dart';
import 'package:all_in_one_admin/screens/theUser.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "All In One",
    debugShowCheckedModeBanner: false,
    initialRoute: LoadingScreen.id,
    routes: {
      LoadingScreen.id: (context) => LoadingScreen(context),
      CamScanner.id: (context) => const CamScanner(),
      HomeScreen.id: (context) => const HomeScreen(),
      AddUser.id: (context) => const AddUser(),
      AllUsers.id: (context) => const AllUsers(),
      TheUser.id: (context) => const TheUser(),
      HistoryScreen.id: (context) => const HistoryScreen(),
      OffersScreen.id: (context) => const OffersScreen(),
      AddUser.id: (context) => const AddOfferScreen()
    },
  ));
}
