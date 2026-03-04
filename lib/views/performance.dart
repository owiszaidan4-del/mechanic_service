import 'dart:developer';

import 'package:car_serves/constant.dart';
import 'package:car_serves/service/Performance/calcPerFormance.dart';
import 'package:car_serves/widget/Performance/Performance_Arrow_left_rhight.dart';
import 'package:car_serves/widget/Performance/Performance_Statment.dart';
import 'package:car_serves/widget/Performance/Performance_gridView.dart';
import 'package:car_serves/widget/sheetNewOrderWidget/appBar_of_sheet_new_order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Performance extends StatefulWidget {
  @override
  State<Performance> createState() => _PerformanceState();
}

int second = int.parse(getDocName().split('W')[1]);

class _PerformanceState extends State<Performance> {
  @override
  Widget build(BuildContext context) {
    final arr = getDocName().split('W');
    final first = arr[0];

    Future<DocumentSnapshot<Map<String, dynamic>>> streamPerformace =
        FirebaseFirestore.instance
            .collection("mechanicPerformance")
            .doc(currentUser)
            .collection("weeklyState")
            .doc("${first}W$second")
            .get();
    log(second.toString());
    return Scaffold(
      appBar: AppBar(title: Text("تقييمك الحالي"), centerTitle: true),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: FutureBuilder(
            future: streamPerformace,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              if (!snapshot.hasData || snapshot.data?.data() == null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Left_Right_Button(
                      text: "الاسبوع",
                      onTapLeft: () {
                        setState(() {
                          second = second + 1;
                        });
                      },
                      onTapRight: () {},
                    ),
                    Text("لا يوجد تقييم لهذا الاسبوع"),
                  ],
                );
              }
              final data = snapshot.data!.data();
              final calcPerformance = Calcperformance(
                acceptedCount: data!["acceptedCount"],
                cancelledCount: data["cancelledCount"],
                completedCount: data["completedCount"],
                totalRequests: data["totalRequests"],
                totalWorkMinutes: data["totalWorkMinutes"],
              );
              final performance = calcPerformance.calcPerformance() as int;
              return Column(
                spacing: 10,
                children: [
                  Left_Right_Button(
                    text: "الاسبوع الحالي",
                    onTapLeft: () {},
                    onTapRight: () {
                      setState(() {
                        second = second - 1;
                      });
                    },
                  ),
                  Performance_gridView(
                    completedOrder: data["completedCount"],
                    avgAcceptedOrder: calcPerformance.avgAcceptedOrder(),
                    performance: performance,
                    workHours: calcPerformance.workHours(),
                  ),
                  Performance_Statment(performance: performance),
                  Container(
                    color: Colors.grey.withOpacity(0.2),
                    width: double.infinity,
                    height: 10,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class Left_Right_Button extends StatelessWidget {
  Left_Right_Button({
    super.key,
    required this.text,
    required this.onTapLeft,
    required this.onTapRight,
  });
  final String text;
  void Function()? onTapRight;
  void Function()? onTapLeft;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onTapRight,
          child: Performance_Arrow_left_rhight(left: false),
        ),
        Text(text),
        GestureDetector(
          onTap: onTapLeft,
          child: Performance_Arrow_left_rhight(left: true),
        ),
      ],
    );
  }
}
