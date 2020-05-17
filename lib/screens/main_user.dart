import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodorder/screens/signin.dart';
import 'package:foodorder/utility/singout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainUser extends StatefulWidget {
  @override
  _MainUserState createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
  String user_name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print("getdata = " + preferences.getString('user_name'));
    setState(() {
      user_name = preferences.getString('user_name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(user_name != null ? "Welcome : $user_name" : "Welcome User"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                signOutUser(context);
              })
        ],
      ),
    );
  }
}
