import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello_world/Models/Location.dart';
import 'package:hello_world/ui/Shared/network.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';
import '../Shared/globals.dart';

class CustomDrawer extends StatefulWidget {

  final Function closeDrawer;

  const CustomDrawer({Key key, this.closeDrawer}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  SharedPreferences sharedPreferences;
  network net = new network();
  bool Loaded = false;
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      color: Colors.white,
      width: mediaQuery.size.width * 0.60,
      height: mediaQuery.size.height,
      child : getDrowerLabels());
  }
  getDrowerLabels() {
    return ListView(
    scrollDirection: Axis.vertical,
    children: <Widget>[

      Container(
          width: double.infinity,
          height: 150,
          color: Colors.grey.withAlpha(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/saitama.jpg",
                width: 120,
                height: 120,
              ),
              SizedBox(
                height: 10,
              ),
              Text(Global.CurrenUser.FirstName + ' '+ Global.CurrenUser.LastName)
            ],
          )),

      ListTile(
        onTap: (){
          debugPrint("Tapped Profile");
          logout();
        },
        leading: Icon(Icons.person),
        title: Text(
          "Your Profile",
        ),
      ),
      /*FutureBuilder(
          initialData: "loading",

          builder: (context , snapshot) {
            return Column(
              children:
                _getListings(),

            );
          }


      ),*/
      Column(
        children: _getListings(),
      ),
      Divider(
        height: 1,
        color: Colors.grey,
      ),

      ListTile(
        onTap: () {
          setState(() {

          });
        },
            leading: Icon(Icons.payment),
            title: Text("Payments"),
      ),
      Divider(
        height: 1,
        color: Colors.grey,
      ),
      ListTile(
        onTap: () {
          debugPrint("Tapped Notifications");
        },
        leading: Icon(Icons.notifications),
        title: Text("Notifications"),
      ),
      Divider(
        height: 1,
        color: Colors.grey,
      ),
      ListTile(
        onTap: () {
          debugPrint("Tapped Log Out");
          logout();

        },
        leading: Icon(Icons.exit_to_app),
        title: Text("Log Out"),
      ),
    ],
  );
  }
  List _listings = new List();

  _getListings() {
    List listings = new List<Widget>();
    int i = 0;
    if (Global.UserLocations.length == 0)
      {
        print("refrech data from _getListings");
        net.refrechData();
      }
    Global.UserLocations.forEach((element) {

      listings.add(
        Column(
          children: <Widget>[
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                pr(element);
                print("Tapped " + element.SiteName);
                Navigator.of(context).pushNamed('/location',arguments: element);
                setState(() {
                  widget.closeDrawer();
                });
              },
              leading: Icon(Icons.location_on),
              title: Text(element.SiteName.toString()),
            ),
          ],
        ),
      );
    });
    return listings;
  }
  pr(arg)
  {
    print(arg.toString());
  }
  logout() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    sharedPreferences.commit();
    Global.CurrenUser = null;
    Global.UserLocations= new List<Location>();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomeView()), (Route<dynamic> route) => false);
    /*Navigator.of(context).pushNamed(
      '/',
    );*/
  }
}