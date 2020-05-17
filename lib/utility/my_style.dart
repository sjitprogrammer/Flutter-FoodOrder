import 'package:flutter/material.dart';

class MyStyle {
  Color DarkColor = Colors.blue.shade900;
  Color PrimaryColor = Colors.lightBlueAccent;

  Container showLogo() => Container(
        width: 120,
        child: Image.asset('images/logo.png'),
      );

  Text showAppName(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 24,
            color: Colors.blue.shade900,
            fontWeight: FontWeight.bold),
      );

  Text showTitle(String str) => Text(
        str,
        style: TextStyle(
          color: MyStyle().DarkColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );

  SizedBox showSizedBox() {
    return SizedBox(
      height: 20,
    );
  }

  MyStyle();
}
