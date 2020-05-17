import 'package:flutter/material.dart';
import 'package:foodorder/screens/main_rider.dart';
import 'package:foodorder/screens/main_shop.dart';
import 'package:foodorder/screens/main_user.dart';
import 'package:foodorder/screens/signin.dart';
import 'package:foodorder/screens/signup.dart';
import 'package:foodorder/utility/alert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUserLogin();
  }

  Future<Null> checkUserLogin() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String userType = preferences.getString('user_type');
      if (userType != null) {
        switch (userType) {
          case "user":
            routeToService(MainUser());
            break;
          case "shop":
            routeToService(MainShop());
            break;
          case "rider":
            routeToService(MainRider());
            break;
          default:
            routeToService(MainUser());
        }
      }
    } catch (e) {
      CustomAlertDialog(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDrawer(),
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Text("is empty"),
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showDrawerHeader(),
            showSignIn(),
            showSignUp(),
          ],
        ),
      );

  ListTile showSignIn() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text("Sign In"),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => SignInPage());
        Navigator.push(context, route);
      },
    );
  }

  ListTile showSignUp() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text("Sign Up"),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => SignUpPage());
        Navigator.push(context, route);
      },
    );
  }

  UserAccountsDrawerHeader showDrawerHeader() {
    return UserAccountsDrawerHeader(
        accountName: Text('Guest'), accountEmail: Text("Please Login"));
  }

  void routeToService(Widget page) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => page);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}
