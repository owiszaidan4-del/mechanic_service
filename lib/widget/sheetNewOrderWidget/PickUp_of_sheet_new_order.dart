import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PickUp_of_sheet_new_order extends StatelessWidget {
  final String placemark;
  PickUp_of_sheet_new_order({required this.placemark});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_on, color: Colors.blue),
        Text("الموقع:", style: TextStyle(color: Colors.black)),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Text(
            placemark,
            style: TextStyle(overflow: TextOverflow.ellipsis),
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
