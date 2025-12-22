import 'package:car_serves/constant.dart';
import 'package:flutter/material.dart';

class statment_goToRegester extends StatelessWidget {
  statment_goToRegester({
    super.key,
    required this.ontap,
    required this.goToTxt,
    required this.text,
  });
  final String goToTxt;
  final String text;
  void Function() ontap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: ontap,
          child: Text(goToTxt, style: TextStyle(color: hintColor)),
        ),
        Text(text),
      ],
    );
  }
}
