import 'package:car_serves/constant.dart';
import 'package:car_serves/widget/ItemsOfGradeProfilePage.dart';
import 'package:car_serves/widget/ItemsOfGradeProfilePage2.dart';
import 'package:car_serves/widget/topConteanerProfilePage.dart';
import 'package:flutter/material.dart';

class Profileview extends StatelessWidget {
  List<ItemsOfGradeProfilePage2> items = [
    ItemsOfGradeProfilePage2(
      onTap: () {},
      desc: "الهوية الشخصية",
      image: AssetImage("asset/personal-info.png"),
    ),
    ItemsOfGradeProfilePage2(
      onTap: () {},
      desc: "الحساب",
      image: AssetImage("asset/bank-acount.png"),
    ),
    ItemsOfGradeProfilePage2(
      onTap: () {},
      desc: "عدم المحكومية",
      image: AssetImage("asset/google-docs.png"),
    ),
    ItemsOfGradeProfilePage2(
      onTap: () {},
      desc: "وثائق",
      image: AssetImage("asset/authenticity.png"),
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
            topConteanerProfilePage(pop: true),

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

            SliverToBoxAdapter(child: Divider()),
            SliverToBoxAdapter(
              child: Center(
                child: Text(
                  "معلومات اخرى",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
