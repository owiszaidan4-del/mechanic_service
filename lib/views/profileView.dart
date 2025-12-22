import 'package:car_serves/constant.dart';
import 'package:car_serves/widget/ItemsOfGradeProfilePage.dart';
import 'package:car_serves/widget/topConteanerProfilePage.dart';
import 'package:flutter/material.dart';

class Profileview extends StatelessWidget {
  List<ItemsOfGradeProfilePage> items = [
    ItemsOfGradeProfilePage(
      onTap: () {},
      desc: "الاداء الشهري",
      image: AssetImage("asset/icons8-crown-50.png"),
    ),
    ItemsOfGradeProfilePage(
      onTap: () {},
      desc: "الاشعارات",
      image: AssetImage("asset/Alarm.png"),
    ),
    ItemsOfGradeProfilePage(
      onTap: () {},
      desc: "تواصل معنا",
      image: AssetImage("asset/callCenter.png"),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(backgroundColor: const Color.fromARGB(255, 236, 243, 247)),
      body: DefaultTextStyle(
        style: TextStyle(color: Colors.white),
        child: CustomScrollView(
          slivers: [
            topConteanerProfilePage(),

            SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4 / 3,
              ),
              itemBuilder: (context, index) {
                return items[index];
              },
              itemCount: items.length,
            ),
          ],
        ),
      ),
    );
  }
}
