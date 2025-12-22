import 'package:car_serves/constant.dart';
import 'package:car_serves/views/centerView.dart';
import 'package:car_serves/views/mapView.dart';
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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Centerview(),

        // IndexedStack(index: index, children: pages),
        // bottomNavigationBar: Container(
        //   height: MediaQuery.of(context).size.height * 0.08,

        //   decoration: BoxDecoration(
        //     color: Colors.white.withOpacity(0.3),
        //     borderRadius: BorderRadius.circular(12),
        //   ),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: [
        //       IconButton(
        //         icon: Icon(Icons.home),
        //         onPressed: () {
        //           setState(() {
        //             index = 0;
        //             resetColor(index);
        //           });
        //         },
        //         color: iconsColor[0],
        //       ),

        //       // IconButton(
        //       //   icon: Icon(Icons.attach_money),
        //       //   onPressed: () {
        //       //     setState(() {
        //       //       index = 1;
        //       //       resetColor(index);
        //       //     });
        //       //   },
        //       //   color: iconsColor[2],
        //       // ),
        //       // IconButton(
        //       //   icon: Icon(Icons.menu),
        //       //   onPressed: () {
        //       //     setState(() {
        //       //       index = 2;
        //       //       resetColor(index);
        //       //     });
        //       //   },
        //       //   color: iconsColor[3],
        //       // ),
        //       // IconButton(
        //       //   icon: Icon(Icons.person),
        //       //   onPressed: () {
        //       //     setState(() {
        //       //       index = 1;
        //       //       resetColor(index);
        //       //     });
        //       //   },
        //       //   color: iconsColor[1],
        //       // ),
        //     ],
        //   ),
        // ),
      ),
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
