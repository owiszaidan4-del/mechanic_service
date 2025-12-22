import 'dart:developer';

import 'package:car_serves/views/mapView.dart';
import 'package:car_serves/views/profileView.dart';
import 'package:car_serves/widget/ItemsOfGradeProfilePage.dart';
import 'package:car_serves/widget/Menue.dart';
import 'package:car_serves/widget/MenueButton.dart';
import 'package:car_serves/widget/MenueOfCenterView.dart';
import 'package:car_serves/widget/StateOfWork.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Centerview extends StatefulWidget {
  @override
  State<Centerview> createState() => _CenterviewState();
}

class _CenterviewState extends State<Centerview> {
  bool isOpenMenue = false;
  List<ItemsOfGradeProfilePage> items = [
    ItemsOfGradeProfilePage(
      onTap: () {},
      desc: "الاداء الشهري",
      image: AssetImage("asset/good-feedback.png"),
    ),
    ItemsOfGradeProfilePage(
      onTap: () {},
      desc: "الاشعارات",
      image: AssetImage("asset/message-notification.png"),
    ),
    ItemsOfGradeProfilePage(
      onTap: () {},
      desc: "تواصل معنا",
      image: AssetImage("asset/live-chat.png"),
    ),

    ItemsOfGradeProfilePage(
      onTap: () {},
      desc: "المدفوعات",
      image: AssetImage("asset/money.png"),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Mapview(),
          StateOfWork(),
          MenueButton(
            onPressed: () {
              setState(() {
                isOpenMenue = !isOpenMenue;
              });
              log(isOpenMenue.toString());
            },
          ),
          Menue(
            onHorizontalDragUpdate: (details) {
              if (isOpenMenue && details.delta.dx > 8) {
                setState(() {
                  isOpenMenue = false;
                });
              }
            },
            items: items,
            transform: Matrix4.translationValues(isOpenMenue ? 0 : 300, 0, 0),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.25,
            minChildSize: 0.15,
            maxChildSize: 0.7,
            builder: (context, scrollController) {
              return ListView(
                controller: scrollController,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          color: Colors.black,
                          blurStyle: BlurStyle.outer,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
