import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Issue_of_sheet_new_order extends StatelessWidget {
  final String descOfIssue;
  Issue_of_sheet_new_order({required this.descOfIssue});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Icon(Icons.error_outline, color: Colors.red),
        Text("العطل: ", style: TextStyle(color: Colors.black)),
        Text(descOfIssue),
      ],
    );
  }
}
