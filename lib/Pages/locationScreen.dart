import 'package:flutter/material.dart';
import 'package:hello_world/Models/Location.dart';
import 'package:hello_world/Models/Sensor.dart';
import 'package:hello_world/Pages/Home.dart';
import 'package:hello_world/ui/Shared/globals.dart';
import 'package:hello_world/ui/Shared/network.dart';

class locationScreen extends StatefulWidget {
  final Location location;
  locationScreen({Key key,@required this.location}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _locationScreen();

}

class _locationScreen extends State<locationScreen>{
  network net = new network();
  List<Sensor> sensorList = new List<Sensor>();
  bool _Loaded = false;
  Future fut;

  @override
  void initState() {
    fut = load_data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.location.SiteName , style: TextStyle(
            color: Colors.black
        )),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0.0,
        backgroundColor: Global.white,
      ),
      body: _buildLocationScreen(),
    );
  }
  Widget _buildLocationScreen() {

      //_Loaded ? CircularProgressIndicator(): load_data();
    return Container(
      child: new FutureBuilder<List<Sensor>>(
        future: fut, // async work
        builder: (BuildContext context, AsyncSnapshot<List<Sensor>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return new Text('Loading....');
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
                return new Text('Result: ${snapshot.data}');
          }
        },
      )
    );
      }

  load_data() {
    return net.sensorsData(widget.location.id);
  }
  }
