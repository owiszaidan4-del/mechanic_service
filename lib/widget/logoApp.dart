import 'package:car_serves/constant.dart';
import 'package:car_serves/widget/linearGradentMask.dart';
import 'package:flutter/material.dart';

class logoApp extends StatelessWidget {
  const logoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return linearGradentMask(
      widget: Icon(
        Icons.car_crash_outlined,
        size: MediaQuery.of(context).size.width * 0.5,
        color: Colors.white, // مهم تكون white
      ),
    );
  }
}
