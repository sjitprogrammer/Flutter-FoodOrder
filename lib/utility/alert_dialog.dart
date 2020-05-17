import 'package:flutter/material.dart';
import 'package:foodorder/utility/my_style.dart';

Future<void> CustomAlertDialog(BuildContext context, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(message),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "ตกลง",
                style: TextStyle(
                  color: MyStyle().DarkColor,
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
