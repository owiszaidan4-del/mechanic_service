import 'package:car_serves/widget/bottomSheet/abbPar.dart';
import 'package:flutter/material.dart';

class BottomSheet_StateNotWorking extends StatelessWidget {
  const BottomSheet_StateNotWorking({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        abbPar(),
        Container(
          width: width * 0.3,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                blurStyle: BlurStyle.outer,
                color: Colors.black,
              ),
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Image.asset(
                "asset/circle.png",
                width: 23,
                height: 24,
                color: Colors.white,
              ),
              Text(
                " ابدأ الان",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Text("غير متاح", style: TextStyle(fontSize: 10)),
        Text(
          "غير حالة العمل الى (يعمل ) لتتمكن من استقبال الطلبات",
          style: TextStyle(fontSize: 8, color: Colors.white),
        ),
      ],
    );
  }
}
