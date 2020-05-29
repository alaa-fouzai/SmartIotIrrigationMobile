import 'package:flutter/material.dart';
import 'package:hello_world/ui/Shared/globals.dart';
import 'package:hello_world/ui/Shared/network.dart';
import 'package:hello_world/ui/Widgets/CustomDrawer.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
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
         leading: GestureDetector(
           onTap: () {
             print("menu pressed");
             setState(() {
               drawerStatus = drawerStatus == FSBStatus.FSB_OPEN ? FSBStatus.FSB_CLOSE : FSBStatus.FSB_OPEN;
             });
           },
            child: Icon(
            Icons.menu,  // add custom icons also
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
          drawerBackgroundColor: Colors.deepOrange,
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
          backgroundColor: Colors.deepOrange,
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
    return Container(
      color: Colors.black.withAlpha(200),
      child: Center(child: Text(Global.UserLocations.length.toString(),style: TextStyle(fontSize: 20,color: Colors.white),),),
    );
  }
}
