import 'package:flutter/material.dart';
import 'package:foodorder/screens/create_info_shop.dart';
import 'package:foodorder/utility/my_style.dart';
class ShopInfo extends StatefulWidget {
  @override
  _ShopInfoState createState() => _ShopInfoState();
}

class _ShopInfoState extends State<ShopInfo> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      MyStyle()
          .TitleCenter(context, "ยังไม่มีข้อมูลของร้านกรุณาเพิ่มข้อมูลค่ะ!"),
      _addEditButton(),
    ]);
  }

  Row _addEditButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: FloatingActionButton(
                child: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateInfoShop()));
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}

