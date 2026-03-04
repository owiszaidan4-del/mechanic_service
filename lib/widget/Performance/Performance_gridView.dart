import 'package:car_serves/constant.dart';
import 'package:car_serves/service/Performance/calcPerFormance.dart';
import 'package:car_serves/widget/Performance/Performance_itemOfGrid.dart';
import 'package:car_serves/widget/sheetNewOrderWidget/appBar_of_sheet_new_order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Performance_gridView extends StatelessWidget {
  const Performance_gridView({
    super.key,
    required this.performance,
    required this.avgAcceptedOrder,
    required this.completedOrder,
    required this.workHours,
  });
  final int performance;
  final double avgAcceptedOrder;
  final int completedOrder;
  final String workHours;

  @override
  Widget build(BuildContext context) {
    final streamPerformace = FirebaseFirestore.instance
        .collection("mechanicPerformance")
        .doc(currentUser)
        .collection("weeklyState")
        .doc(getDocName())
        .snapshots();
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
            value: "${performance.round()}%",
          ),
          Performance_itemOfGrid(
            image: AssetImage("asset/clock-hands.png"),
            txt: "ساعات العمل",
            value: workHours,
          ),
          Performance_itemOfGrid(
            image: AssetImage("asset/check.png"),
            txt: "نسبة القبول",
            value: "${avgAcceptedOrder.round()}",
          ),
          Performance_itemOfGrid(
            image: AssetImage("asset/cheke_double.png"),
            txt: "الطلب المكتمل",
            value: completedOrder.toString(),
          ),
        ],
      ),
    );
  }
}
