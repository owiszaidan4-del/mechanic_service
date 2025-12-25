import 'package:flutter/material.dart';

class RecordTasks_DoubleFrame_unCompleate extends StatelessWidget {
  const RecordTasks_DoubleFrame_unCompleate({
    super.key,
    required this.width,
    required this.numOfTask,
  });

  final double width;
  final String numOfTask;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: DefaultTextStyle(
        style: TextStyle(fontSize: 8),
        child: Container(
          width: width * 0.2,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              "ملغي(0)",
              style: TextStyle(color: Colors.black.withOpacity(0.4)),
            ),
          ),
        ),
      ),
    );
  }
}
