import 'package:car_serves/constant.dart';
import 'package:car_serves/widget/GridOfMenue.dart';
import 'package:car_serves/widget/ItemsOfGradeProfilePage.dart';
import 'package:flutter/material.dart';

class Performance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الاداء الشهري"), centerTitle: true),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            spacing: 10,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Performance_Arrow_left_rhight(left: false),
                  Text("الشهر الحالي"),
                  Performance_Arrow_left_rhight(left: true),
                ],
              ),
              Performance_gridView(),
              Performance_Statment(),
              Container(
                color: Colors.grey.withOpacity(0.2),
                width: double.infinity,
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Performance_Statment extends StatelessWidget {
  const Performance_Statment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            blurStyle: BlurStyle.outer,
            color: Colors.black,
            offset: Offset(0.5, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DefaultTextStyle(
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: AssetImage("asset/condecoration.png"),

                width: 30,
                height: 30,
              ),
              SizedBox(width: 20),
              Column(
                children: [
                  Row(children: [Text("تقييمك الحالي هو   "), Text("--")]),
                  Text(
                    " سيظهر تقييمك عند العملاء ",
                    style: TextStyle(fontSize: 8),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star_border_purple500, color: Colors.brown),
                      Text(
                        "احرص دائما ان يكون تقييمك بين 2 و 1",
                        style: TextStyle(fontSize: 8),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Performance_gridView extends StatelessWidget {
  const Performance_gridView({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GridView(
        padding: EdgeInsets.all(8),

        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 1,
        ),

        children: [
          Performance_itemOfGrid(
            image: AssetImage("asset/christmas-stars.png"),
            txt: "التقييم",
          ),
          Performance_itemOfGrid(
            image: AssetImage("asset/clock-hands.png"),
            txt: "ساعات العمل",
          ),
          Performance_itemOfGrid(
            image: AssetImage("asset/check.png"),
            txt: "نسبة القبول",
          ),
          Performance_itemOfGrid(
            image: AssetImage("asset/cheke_double.png"),
            txt: "الطلب المكتمل",
          ),
        ],
      ),
    );
  }
}

class Performance_itemOfGrid extends StatelessWidget {
  const Performance_itemOfGrid({
    super.key,
    required this.image,
    required this.txt,
  });

  final ImageProvider<Object> image;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {},
        child: DefaultTextStyle(
          style: TextStyle(overflow: TextOverflow.clip),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  color: Colors.black.withOpacity(0.4),
                  blurStyle: BlurStyle.outer,
                ),
              ],
            ),
            child: Row(
              spacing: 20,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: colors),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Image(image: image, color: Colors.white),
                    ),
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "-",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    Text(
                      txt,
                      style: TextStyle(color: Colors.grey, fontSize: 8),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Performance_Arrow_left_rhight extends StatelessWidget {
  const Performance_Arrow_left_rhight({super.key, required this.left});
  final bool left;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,

      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.4),
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(12),
      ),
      child: left
          ? Directionality(
              textDirection: TextDirection.ltr,
              child: Icon(Icons.arrow_back_ios),
            )
          : Icon(Icons.arrow_back_ios),
    );
  }
}
