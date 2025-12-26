import 'package:car_serves/constant.dart';
import 'package:car_serves/views/Awards.dart';
import 'package:car_serves/views/PaysRecord.dart';
import 'package:car_serves/views/RecordTasks.dart';
import 'package:car_serves/views/centerView.dart';
import 'package:car_serves/views/mapView.dart';
import 'package:car_serves/views/notifacation.dart';
import 'package:car_serves/views/performance.dart';
import 'package:car_serves/views/profileView.dart';
import 'package:flutter/material.dart';

class Homeview2 extends StatefulWidget {
  @override
  State<Homeview2> createState() => _Homeview2State();
}

class _Homeview2State extends State<Homeview2> {
  final List<Widget> pages = [Centerview()];

  int index = 0;
  Color defultColorIcons = Colors.black;
  Color colorFoucs = Colors.red;
  List<Color> iconsColor = [
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "notifacation": (context) => Notifacation(),
        "performance": (context) => Performance(),
        "Paysrecord": (context) => Paysrecord(),
        "ProfileView": (context) => Profileview(),
        "Awards": (context) => Awards(),
      },
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Centerview()),
    );
  }

  resetColor(int index) {
    int i = 0;
    while (i < 4) {
      if (i != index) {
        iconsColor[i] = defultColorIcons;
      } else {
        iconsColor[i] = colorFoucs;
      }
      i++;
    }
  }
}
