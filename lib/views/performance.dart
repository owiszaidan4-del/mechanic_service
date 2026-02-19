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
              Left_Right_Button(
                text: "الشهر الحالي",
                onTapLeft: () {},
                onTapRight: () {},
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
