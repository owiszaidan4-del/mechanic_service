import 'package:car_serves/widget/Performance/Performance_itemOfGrid.dart';
import 'package:flutter/material.dart';

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
