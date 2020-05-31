import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodorder/screens/home.dart';
import 'package:foodorder/screens/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> signOutUser(BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
//    await preferences.setInt('user_id', null);
//    await preferences.setString('user_name', null);
//    await preferences.setString('user_type', null);
//  exit(0);
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => Home());
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
}
