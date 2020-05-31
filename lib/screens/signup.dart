import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foodorder/models/users.dart';
import 'package:foodorder/utility/alert_dialog.dart';
import 'package:foodorder/utility/my_style.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String chooseType, displayName, userName, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: <Widget>[
          buildShowLogo(),
          MyStyle().showSizedBox(),
          buildShowAppName(),
          MyStyle().showSizedBox(),
          nameForm(),
          MyStyle().showSizedBox(),
          userForm(),
          MyStyle().showSizedBox(),
          passwordForm(),
          MyStyle().showSizedBox(),
          MyStyle().showTitle("ประเภท:"),
          userRadio(),
          shopRadio(),
          riderRadio(),
          MyStyle().showSizedBox(),
          showButtonRegister(),
        ],
      ),
    );
  }

  Row userRadio() => Row(
        children: <Widget>[
          Radio(
              value: "user",
              groupValue: chooseType,
              onChanged: (value) {
                setState(() {
                  chooseType = value;
                });
              }),
          Text(
            "ผู้สั่งอาหาร",
            style: TextStyle(
                color: MyStyle().DarkColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          )
        ],
      );

  Row shopRadio() => Row(
        children: <Widget>[
          Radio(
              value: "shop",
              groupValue: chooseType,
              onChanged: (value) {
                setState(() {
                  chooseType = value;
                });
              }),
          Text(
            "เจ้าของร้านอาหาร",
            style: TextStyle(
                color: MyStyle().DarkColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          )
        ],
      );

  Row riderRadio() => Row(
        children: <Widget>[
          Radio(
              value: "rider",
              groupValue: chooseType,
              onChanged: (value) {
                setState(() {
                  chooseType = value;
                });
              }),
          Text(
            "ผู้ส่งอาหาร",
            style: TextStyle(
                color: MyStyle().DarkColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          )
        ],
      );

  Widget buildShowAppName() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MyStyle().showAppName('Food Order'),
        ],
      );

  Widget buildShowLogo() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MyStyle().showLogo(),
        ],
      );

  Widget nameForm() => Container(
      width: 250,
      child: TextField(
        onChanged: (value) => displayName = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.account_circle,
            color: MyStyle().DarkColor,
          ),
          labelStyle: TextStyle(color: MyStyle().DarkColor),
          labelText: 'Display name',
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().DarkColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().PrimaryColor)),
        ),
      ));

  Widget userForm() => Container(
      width: 250,
      child: TextField(
        onChanged: (value) => userName = value.trim(),
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

  Widget passwordForm() => Container(
      width: 250,
      child: TextField(
        obscureText: true,
        onChanged: (value) => password = value.trim(),
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

  Widget showButtonRegister() {
    return Container(
      width: 250,
      height: 50,
      child: RaisedButton(
        onPressed: () {
          print(
              "displayName = $displayName , userName = $userName ,password = $password , chooseType = $chooseType");
          if (displayName == null ||
              displayName.isEmpty ||
              userName == null ||
              userName.isEmpty ||
              password == null ||
              password.isEmpty) {
            CustomAlertDialog(context, "กรุณาตรวจสอบ ข้อมูลให้ครบถ้วน");
          } else if (chooseType == null) {
            CustomAlertDialog(context, "กรุณาเลือกประเภทของ ผู้ใข้งาน");
          } else {
            registerToServer();
          }
        },
        child: Text(
          "Register",
          style: TextStyle(color: Colors.white),
        ),
        color: MyStyle().DarkColor,
      ),
    );
  }

  Future<void> registerToServer() async {
    var dio = Dio();
    String url = "http://10.0.1.40/foodorder/public/api/user/register";
//    String url = "http://10.0.1.40/foodorder/public/api/user/register?displayName=$displayName&userName=$userName&passWord=$password&type=$chooseType";
    var data = {
      "displayName": displayName,
      "userName": userName,
      "passWord": password,
      "type": chooseType
    };
    try {
      Response response = await dio.post(url, data: FormData.fromMap(data));
//    Response response = await dio.get(url);
      var user = Users.fromJson(json.decode(response.data));
      if (user.status) {
        Navigator.pop(context);
        print("response = " + response.data.toString());
      } else {
        CustomAlertDialog(context,user.msg);
      }
    } catch (e) {
      CustomAlertDialog(context, e.toString());
    }
  }
}
