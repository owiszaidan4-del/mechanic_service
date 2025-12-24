import 'package:car_serves/constant.dart';
import 'package:flutter/material.dart';

class Performance_Arrow_left_rhight extends StatelessWidget {
  const Performance_Arrow_left_rhight({super.key, required this.left});
  final bool left;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,

      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.4),
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(12),
      ),
      child: left
          ? Directionality(
              textDirection: TextDirection.ltr,
              child: Icon(Icons.arrow_back_ios),
            )
          : Icon(Icons.arrow_back_ios),
    );
  }
}
