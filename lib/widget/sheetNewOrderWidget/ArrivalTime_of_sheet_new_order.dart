import 'package:flutter/material.dart';

class ArrivalTime_of_sheet_new_order extends StatelessWidget {
  final String arrivaltime;
  ArrivalTime_of_sheet_new_order({required this.arrivaltime});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.timelapse_sharp),
        Text("وقت الوصول: ", style: TextStyle(color: Colors.black)),
        Text(arrivaltime),
      ],
    );
    ;
  }
}
