import 'package:flutter/material.dart';

class RecordTasks_DoubleFrame_Compleate extends StatelessWidget {
  const RecordTasks_DoubleFrame_Compleate({super.key, required this.numOfTask});

  final String numOfTask;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {},
      child: DefaultTextStyle(
        style: TextStyle(fontSize: 8),
        child: Container(
          width: width * 0.2,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              "مكتمل($numOfTask)",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
