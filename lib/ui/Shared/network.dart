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
  Future<List<Sensor>> sensorsData(locationId) async {
   //print("sensorsData");
    print('sensorsData /***************************************************');
      String data =
          'token='+  Global.token + '&location_id='+locationId
      ;
      Response response = await http.get(Global.ServerIp+'/api/dashboard/SensorsData?'+data,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          }
      );
      //print(response.body);
      final Map parsed = json.decode(response.body);
      //print(parsed['response']);
      List<dynamic> list = parsed['response'];
      //print('list'+list.toString());
      List<Sensor> list1 = new List<Sensor>();
      list.forEach((element) async {
            print("element :"+element.toString());
            List<double> coo = new List<double>();
            coo.add(element['SensorCoordinates'][0]);
            coo.add(element['SensorCoordinates'][1]);
            //{SensorCoordinates: [10.25612619972702, 36.76423817546649], Created_date: 2020-05-14T11:46:23.618Z, data: [{humidite: 30, temperature: 30, batterie: 62, humiditéSol: 25, time: 1589457171501}, ], _id: 5ebd30c8b43a4406c0c96d91, SensorIdentifier: 124, SensorType: temperature, __v: 7, Description: description 124, name: Temperature}
            Sensor s = new Sensor(id:element['_id'], Name: element['name'], SensorType :element['SensorType'], Description :element['Description'], SensorCoordinates : coo, createdate : DateTime.parse(element['Created_date']), data : element['data']);
            list1.add(s);
            });

    return list1;

  }
}

