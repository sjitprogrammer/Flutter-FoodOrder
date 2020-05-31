import 'package:flutter/material.dart';
import 'package:foodorder/utility/my_style.dart';
import 'package:foodorder/utility/singout.dart';
import 'package:foodorder/widgets/foods_list_shop.dart';
import 'package:foodorder/widgets/info_shop.dart';
import 'package:foodorder/widgets/order_list_shop.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainShop extends StatefulWidget {
  @override
  _MainShopState createState() => _MainShopState();
}

class _MainShopState extends State<MainShop> {
  String user_name;
  Widget _currentPage = OrderListShop();
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
            Text(user_name != null ? "Welcome : $user_name" : "Welcome Shop"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                signOutUser(context);
              })
        ],
      ),
      drawer: showDrawer(),
      body: _currentPage,
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showDrawerHeader(),
            showMenuHome(),
            showMenuFood(),
            showMenuInfo(),
            showMenuSignOut()
          ],
        ),
      );

  ListTile showMenuHome() => ListTile(
        onTap: () {
          setState(() {
            _currentPage = OrderListShop();
          });
          Navigator.pop(context);
        },
        leading: Container(
          padding: EdgeInsets.only(top: 5.0),
          child: Icon(Icons.home),
        ),
        title: Text("รายการอาหารที่ ลูกค้าสั่ง"),
        subtitle: Text("รายการอาหารที่ยังไม่ได้ทำส่งลูกค้า"),
      );

  ListTile showMenuFood() => ListTile(
        onTap: () {
          setState(() {
            _currentPage = ShopListFood();
          });
          Navigator.pop(context);
        },
        leading: Container(
          padding: EdgeInsets.only(top: 5.0),
          child: Icon(Icons.fastfood),
        ),
        title: Text("รายการอาหาร"),
        subtitle: Text("รายการอาหารของร้าน"),
      );

  ListTile showMenuInfo() => ListTile(
        onTap: () {
          setState(() {
            _currentPage = ShopInfo();
          });
          Navigator.pop(context);
        },
        leading: Container(
          padding: EdgeInsets.only(top: 5.0),
          child: Icon(Icons.info),
        ),
        title: Text("รายละเอียด ของร้าน"),
        subtitle: Text("ข้อมูลเกี่ยวกับร้านค้า"),
      );

  ListTile showMenuSignOut() => ListTile(
        onTap: () {
          signOutUser(context);
        },
        leading: Container(
          padding: EdgeInsets.only(top: 5.0),
          child: Icon(Icons.lock),
        ),
        title: Text("Sign Out"),
        subtitle: Text("ออกจากระบบ"),
      );

  UserAccountsDrawerHeader showDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: MyStyle().BackgroundHeader(
          "https://images.pexels.com/photos/1050244/pexels-photo-1050244.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text(user_name),
      accountEmail: Text("Shop"),
    );
  }

  void routeToService(Widget page) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => page);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}
