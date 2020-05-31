import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateInfoShop extends StatefulWidget {
  @override
  _CreateInfoShopState createState() => _CreateInfoShopState();
}

class _CreateInfoShopState extends State<CreateInfoShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop Infomation"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 5.0,
            ),
            nameTextField(),
            addressTextField(),
            phoneTextField(),
            SizedBox(
              height: 5.0,
            ),
            GroupImage(),
            SizedBox(
              height: 10.0,
            ),
            showMap(),
          ],
        ),
      ),
    );
  }

  Widget nameTextField() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            width: 250.0,
            child: TextField(
              decoration: InputDecoration(
                labelText: "ชื่อร้านค้า",
                prefixIcon: Icon(Icons.account_circle),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget addressTextField() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            width: 250.0,
            child: TextField(
              decoration: InputDecoration(
                labelText: "ที่อยู่ร้านค้า",
                prefixIcon: Icon(Icons.home),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget phoneTextField() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            width: 250.0,
            child: TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "เบอร์โทรศัพทร์",
                prefixIcon: Icon(Icons.phone_android),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Row GroupImage() {
    return Row(
      children: <Widget>[
        Expanded(
            flex: 2,
            child: Icon(Icons.camera_alt, size: 36.0, color: Colors.grey)),
        Expanded(
          flex: 4,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Image.asset("images/placeholder_img.png"),
          ),
        ),
        Expanded(
            flex: 2, child: Icon(Icons.image, size: 36.0, color: Colors.grey)),
      ],
    );
  }

  Container showMap() {
    LatLng latLng = LatLng(13.791166, 100.442195);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );
    return Container(
      height: 300.0,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated:(controller) => {},
      ),
    );
  }
}
