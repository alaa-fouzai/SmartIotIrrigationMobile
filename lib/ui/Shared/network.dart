import 'dart:convert';

import 'package:hello_world/Models/Location.dart';
import 'package:hello_world/Models/Sensor.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'globals.dart';

class network {


  String hello()
  {return 'hello';}

  void getSideBarData() async {
    print('getsidebardata /***************************************************');
    String data =
      'token='+  Global.token
    ;
    Response response = await http.get(Global.ServerIp+'/api/dashboard/sidenav/?'+data,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
        );
    print(response.body);
    //final Map parsed = json.decode(response.body);
    //print('getSideBarData' + parsed['response'].toString());
    return ;

  }
  Future<bool> refrechData() async {
  print("refrech data");
  print('getsidebardata /***************************************************');
  if (Global.UserLocations.length == 0)
    {
  String data =
      'token='+  Global.token
  ;
  Response response = await http.get(Global.ServerIp+'/api/location/?'+data,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }
  );
  //print(response.body);
  final Map parsed = json.decode(response.body);
  //print(parsed['Locations']);
  List<dynamic> list = parsed['Locations'];
  //print('list'+list.toString());
  List<Location> list1 ;
  list.forEach((element) async {
    List<double> coo = new List<double>();
    coo.add(element['Coordinates'][0]);
    coo.add(element['Coordinates'][1]);
    //print('coordinence' + element['Sensor_ids'].toString() );
    List<String> LocationId = new List<String>();
    List<dynamic> l1 = new List<dynamic>();
    l1=element['Sensor_ids'];
    l1.forEach((element) {
      LocationId.add(element.toString());
    });
    //print(' Sensor ids ' + LocationId.toString());
    //element {AutomaticIrrigation: false, Coordinates: [25, 120], Created_date: 2020-03-16T08:26:33.571Z, Sensor_ids: [], _id: 5e6f396b292af2263c120cfe, SiteName: site 1, Description: description, __v: 0}
    Location l= new Location(id:element['_id'] ,AutomaticIrrigation: element['AutomaticIrrigation'] ,Coordinates: coo ,Created_date: element['Created_date'] ,Description: element['Description'],Sensor_ids: LocationId,SiteName: element['SiteName']);
    print(" l "+l.toString());
    Global.UserLocations.add(l);
      });
    }
    return true;

  }
}

