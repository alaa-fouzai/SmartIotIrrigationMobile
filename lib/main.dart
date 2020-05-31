import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hello_world/ui/Shared/network.dart';
import 'package:http/http.dart';
import 'dart:developer';
import 'MyRouter.dart';
import 'ui/Shared/globals.dart';
import 'ui/Widgets/button_widget.dart';
import 'ui/Widgets/textfield_widge.dart';
import 'ui/Widgets/wave_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hello_world/Pages/Home.dart';
import 'package:hello_world/Models/User.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  onGenerateRoute: MyRouter.generateRoute,
));
class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController email = TextEditingController();
  SharedPreferences sharedPreferences;
  network net = new network();
  TextEditingController password = TextEditingController();
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }
  bool _isLoading = false;
  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String token = await sharedPreferences.getString("token");
    String user = await sharedPreferences.getString("CurrenUser");
    if(token != null && user != null) {
    print('/****************************************************************************************//');
    print(token);
    print('user :'+user);

    Map user1 = json.decode(user);
    print('user :'+user1.toString());
    Global.CurrenUser = new User.fromJson(user1);

      Global.token = token;
    print("refrech data from checkLoginStatus");
      net.refrechData();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Home()), (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(

      backgroundColor: Global.white,
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height - 200,
            color: Global.greenColor,
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOutQuad,
            top: keyboardOpen ? -size.height / 3.7 : 0.0,
            child: WaveWidget(
              size: size,
              yOffset: size.height / 3.0,
              color: Global.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Login',
                  style: TextStyle(
                    color: Global.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0,30.0,30.0,60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextFieldWidget(
                  controller: email,
                  hintText: 'Email',
                  obscureText: false,
                  prefixIconData: Icons.mail_outline,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                  TextFieldWidget(
                    hintText : 'Password',
                    prefixIconData : Icons.lock_outline,
                    suffixIconData: Icons.visibility_off,
                    obscureText : true,
                    controller : password,
                  ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
              !_isLoading ?
                ButtonWidget(
                  title: 'Login',
                  hasBorder: false,
                  onPressed: () => {
                    setState(() => { _isLoading = true }),
                    login(email.text, password.text),
                    print('here')
                  },
                ) : CircularProgressIndicator(
                backgroundColor: Global.darkGreenColor,
              )
              ],
            ),
          ),
        ],
      ),
    );
  }

  login(email,password) async {
    print('email :'+email);
    print('password :'+password);
    Map data = {
      'email' : email ,
      'password': password
    };
    Response response = await http.post(Global.ServerIp+'/api/users/login',
        headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
       body : jsonEncode(data));
    // print(json.decode(response.body));
    final Map parsed = json.decode(response.body);
    if (parsed.length > 0)
      {
        setState(() => { _isLoading = false });
      }
    if (parsed['status'] == 'err') {
      showAlertDialog(context , parsed['message'] );
    }
    if (parsed['status'] == 'ok') {
      showAlertDialog(context , parsed['message'] );
      User NewUser = new User.fromJson(parsed['UserData'][0]);
      String encodeduser = json.encode(NewUser);
      sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString('CurrenUser', encodeduser);
      await sharedPreferences.setString('token', parsed['token']);
      Global.CurrenUser = NewUser;
      Global.token = parsed['token'];
      print("refrech data from login");
      await net.refrechData();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Home()), (Route<dynamic> route) => false);
      /*Navigator.pushReplacementNamed(context,
      '/home',
      );*/

      /*log out
      * sharedPreferences.clear();
              sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
      *
      *
      * */
    }
  }
  showAlertDialog(BuildContext context, message){
    AlertDialog alert=AlertDialog(
            content: new Row(
              children: [
                Container(margin: EdgeInsets.only(left: 5),child:Text(message )),
                CircularProgressIndicator(
                  backgroundColor: Global.mediumBlue,
                )
                        ],
            ),
              );
    showDialog(barrierDismissible: true,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}
