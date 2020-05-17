import 'package:flutter/material.dart';
import 'package:foodorder/screens/home.dart';

void main()=>runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Food Order",
      home: Home(),
    );
  }
}
