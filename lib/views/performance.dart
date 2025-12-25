import 'package:car_serves/widget/Performance/Performance_Arrow_left_rhight.dart';
import 'package:car_serves/widget/Performance/Performance_Statment.dart';
import 'package:car_serves/widget/Performance/Performance_gridView.dart';
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
              Left_Right_Button(text: "الشهر الحالي"),
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

class Left_Right_Button extends StatelessWidget {
  const Left_Right_Button({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Performance_Arrow_left_rhight(left: false),
        Text(text),
        Performance_Arrow_left_rhight(left: true),
      ],
    );
  }
}
