import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hello_world/Models/Location.dart';
import 'package:hello_world/Models/User.dart';

class Global {
  static const Color white = const Color(0xffffffff);
  static const Color progress = const Color(0xfff555ff);
  static const Color mediumBlue = const Color(0xff4A64FE);
  static const List validEmail = ['test@gmail.com'];
  static const String ServerIp = 'http://192.168.1.3:3000';
  static User CurrenUser = User();
  static List<Location> UserLocations =List<Location>();
  static List<dynamic> SideNav ;
  static String token ;
}