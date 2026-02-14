import 'package:flutter/material.dart';

class ArrivalTime_of_sheet_new_order extends StatelessWidget {
  final double arrivaltime;
  ArrivalTime_of_sheet_new_order({required this.arrivaltime});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.timelapse_sharp),
        Text("وقت الوصول: ", style: TextStyle(color: Colors.black)),
        Text(computeArrivaltime(time: arrivaltime)),
      ],
    );
    ;
  }

  computeArrivaltime({required double time}) {
    Duration dur = Duration(seconds: time.round());

    int hours = dur.inHours;
    int minutes = dur.inMinutes.remainder(60);

    if (hours > 0) {
      return "$hours ساعات و $minutes دقيقة";
    } else {
      return "$minutes دقيقة";
    }
  }
}
