import 'package:flutter/material.dart';

class Distance_of_sheet_new_order extends StatelessWidget {
  final double distanceToDriver;
  Distance_of_sheet_new_order({required this.distanceToDriver});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.social_distance_outlined, color: Colors.green),
        Text("المسافة: ", style: TextStyle(color: Colors.black)),
        Text("على بعد ${(distanceToDriver / 1000).floor()}km "),
      ],
    );
  }
}
