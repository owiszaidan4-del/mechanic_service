import 'package:car_serves/widget/bottomSheet/abbPar.dart';
import 'package:flutter/material.dart';

class bottomSheet_working extends StatelessWidget {
  const bottomSheet_working({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        abbPar(),
        Text(
          "متاح",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("جاري البحث عن طلبات....", style: TextStyle(fontSize: 10)),
            Icon(Icons.search),
          ],
        ),
      ],
    );
  }
}
