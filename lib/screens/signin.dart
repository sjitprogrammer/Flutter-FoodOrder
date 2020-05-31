import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foodorder/models/users.dart';
import 'package:foodorder/screens/main_rider.dart';
import 'package:foodorder/screens/main_shop.dart';
import 'package:foodorder/screens/main_user.dart';
import 'package:foodorder/utility/alert_dialog.dart';
import 'package:foodorder/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MyStyle().showLogo(),
              MyStyle().showAppName("Food Order"),
              MyStyle().showSizedBox(),
              userForm(),
              MyStyle().showSizedBox(),
              PasswordForm(),
              MyStyle().showSizedBox(),
              showButtonLogin(),
            ],
          ),
        ),
      ),
    );
  }

  Widget showButtonLogin() {
    return Container(
      width: 250,
      height: 50,
      child: RaisedButton(
        onPressed: () {
          if (username == null ||
              username.isEmpty ||
              password == null ||
              password.isEmpty) {
            CustomAlertDialog(context, "กรุณาตรวจสอบ ข้อมูลให้ครบถ้วน");
          } else {
            checkLogin();
          }
        },
        child: Text(
          "Login",
          style: TextStyle(color: Colors.white),
        ),
        color: MyStyle().DarkColor,
      ),
    );
  }

  Widget userForm() => Container(
      width: 250,
      child: TextField(
        onChanged: (value) => username = value,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.account_box,
            color: MyStyle().DarkColor,
          ),
          labelStyle: TextStyle(color: MyStyle().DarkColor),
          labelText: 'User name',
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().DarkColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().PrimaryColor)),
        ),
      ));

  Widget PasswordForm() => Container(
      width: 250,
      child: TextField(
        obscureText: true,
        onChanged: (value) => password = value,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: MyStyle().DarkColor,
          ),
          labelStyle: TextStyle(color: MyStyle().DarkColor),
          labelText: 'Password',
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().DarkColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().PrimaryColor)),
        ),
      ));

  Future<void> checkLogin() async {
    var dio = Dio();
    var url = "http://10.0.1.40/foodorder/public/api/user/login";
    var data = {"userName": username, "passWord": password};
    try {
      Response response = await dio.post(url, data: FormData.fromMap(data));
      print(response);
      var user = Users.fromJson(json.decode(response.data));
      if (user.status) {
        switch (user.type) {
          case "user":
            routeToService(MainUser(), user);
            break;
          case "shop":
            routeToService(MainShop(), user);
            break;
          case "rider":
            routeToService(MainRider(), user);
            break;
          default:
            routeToService(MainUser(), user);
        }
//        Navigator.pop(context);
      } else {
        CustomAlertDialog(context, user.msg);
      }
    } catch (e) {
      CustomAlertDialog(context, e.toString());
    }
  }

  Future<Null> routeToService(Widget page, Users users) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', users.id);
    await prefs.setString('user_name', users.username);
    await prefs.setString('user_type', users.type);
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => page);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
//    MaterialPageRoute route =
//        MaterialPageRoute(builder: (context) => page);
//    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}
