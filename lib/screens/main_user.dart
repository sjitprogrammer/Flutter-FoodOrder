import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodorder/screens/signin.dart';
import 'package:foodorder/utility/my_style.dart';
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
      drawer: showDrawer(),
    );
  }

  Drawer showDrawer() => Drawer(
    child: ListView(
      children: <Widget>[
        showDrawerHeader(),
      ],
    ),
  );

  UserAccountsDrawerHeader showDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration:MyStyle().BackgroundHeader("https://images.pexels.com/photos/3584924/pexels-photo-3584924.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text(user_name),
      accountEmail: Text("User"),
    );
  }

  void routeToService(Widget page) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => page);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}
