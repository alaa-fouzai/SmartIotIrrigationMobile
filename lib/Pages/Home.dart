import 'package:flutter/material.dart';
import 'package:hello_world/MyRouter.dart';
import 'package:hello_world/Pages/locationScreen.dart';
import 'package:hello_world/ui/Shared/globals.dart';
import 'package:hello_world/ui/Shared/network.dart';
import 'package:hello_world/ui/Widgets/CustomDrawer.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:hello_world/ui/Widgets/button_widget.dart';
import 'package:swipedetector/swipedetector.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FSBStatus drawerStatus;
  network net = new network();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("Hello Appbar"),
         iconTheme: IconThemeData(
           color: Colors.black, //change your color here
         ),
         elevation: 0.0,
         backgroundColor: Global.white,
         leading: GestureDetector(
           onTap: () {
             print("menu pressed");
             setState(() {
               drawerStatus = drawerStatus == FSBStatus.FSB_OPEN ? FSBStatus.FSB_CLOSE : FSBStatus.FSB_OPEN;
             });
           },
            child: Icon(
            Icons.menu,
              color: Colors.black,// add custom icons also
      ),
    ),
       ),
      body: SwipeDetector(
        onSwipeRight: () {
          setState(() {

            drawerStatus = FSBStatus.FSB_OPEN;
          });
        },
        onSwipeLeft: () {
          setState(() {
            drawerStatus = FSBStatus.FSB_CLOSE;
          });
        },
        child: FoldableSidebarBuilder(
          drawerBackgroundColor: Colors.grey[300],
          drawer: CustomDrawer(closeDrawer: (){
            setState(() {
              drawerStatus = FSBStatus.FSB_CLOSE;
            });
          },),
          screenContents: FirstScreen(),
          status: drawerStatus,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.yellow[700],
          child: Icon(Icons.menu,color: Colors.white,),
          onPressed: () {
            print("refrech data from _HomeState");
            net.refrechData();
            /*setState(() {
              drawerStatus = drawerStatus == FSBStatus.FSB_OPEN ? FSBStatus.FSB_CLOSE : FSBStatus.FSB_OPEN;
            });*/
          }),
    );
  }



}
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.greenColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          buildTop(),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 15),
                  Text(
                    "Planting",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget _buildCard(context, {Widget child}) {
    return Card(
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Container(
        height: 90,
        width: MediaQuery.of(context).size.width,
        child: child,
      ),
    );
  }
  Widget buildTop() {
    return Expanded(
      flex: 4,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(110),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 300,
                child: Text(
                  "Smart Irrigation",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                Global.CurrenUser.Location_ids.length.toString() + " locations",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Text(
                      "since",
                      style: TextStyle(
                        color: Global.greenColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    DateTime.parse(Global.CurrenUser.Created_date).day.toString()+"/" +
                        DateTime.parse(Global.CurrenUser.Created_date).month.toString()+"/"+
                        DateTime.parse(Global.CurrenUser.Created_date).year.toString(),
                    style: TextStyle(
                      color: Global.greenColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    width: 160,
                    child: Image.network(
                      Global.plantImage,
                      fit: BoxFit.fill,
                      alignment: Alignment.bottomCenter,
                    ),
                  )
                ],
              ),
              SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }
}
