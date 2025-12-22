import 'package:car_serves/constant.dart';
import 'package:car_serves/widget/linearGradentMask.dart';
import 'package:flutter/material.dart';

class statment_open extends StatelessWidget {
  const statment_open({super.key, required this.txt});
  final String txt;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          txt,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.03,
            fontWeight: FontWeight.bold,
          ),
        ),
        linearGradentMask(
          widget: Icon(Icons.star_purple500_outlined, color: Colors.white),
        ),
      ],
    );
  }
}
