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

  BoxDecoration BackgroundHeader(String img) {
    return BoxDecoration(
        image: DecorationImage(
      image: NetworkImage(img),
      fit: BoxFit.cover,
    ));
  }

  Widget TitleCenter(context,String message) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width*0.8,
        child: Text(
          message,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  MyStyle();
}
