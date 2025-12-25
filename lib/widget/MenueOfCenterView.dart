import 'package:car_serves/widget/GridOfMenue.dart';
import 'package:car_serves/widget/ItemsOfGradeProfilePage.dart';
import 'package:car_serves/widget/catogriesOfMenue.dart';
import 'package:car_serves/widget/topConteanerProfilePage.dart';
import 'package:flutter/material.dart';

class MenueOfCenterView extends StatelessWidget {
  const MenueOfCenterView({super.key, required this.items});

  final List<ItemsOfGradeProfilePage> items;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        topConteanerProfilePage(pop: false),
        GridOfMenue(items: items),
        catogriesOfMenue(
          onTap: () {
            Navigator.pushNamed(context, "ProfileView");
          },
          text: "ملفي الشخصي",
          icon: Icon(Icons.person_2_rounded),
        ),
        catogriesOfMenue(
          onTap: () {
            Navigator.pushNamed(context, "Awards");
          },
          text: "حوافز",
          icon: Icon(Icons.money),
        ),

        catogriesOfMenue(
          onTap: () {},
          text: "الاعدادات",
          icon: Icon(Icons.settings),
        ),
      ],
    );
  }
}
