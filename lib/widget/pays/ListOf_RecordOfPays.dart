import 'package:flutter/material.dart';

class ListOf_RecordOfPays extends StatelessWidget {
  const ListOf_RecordOfPays({
    super.key,
    required this.date,
    required this.numOfTask,
    required this.totPrice,
  });
  final String date;
  final String numOfTask;
  final String totPrice;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          "RecordTask",
          arguments: {
            "date": date,
            "totPrice": totPrice,
            "numOfTask": numOfTask,
          },
        );
      },
      child: DefaultTextStyle(
        style: TextStyle(fontSize: 10, color: Colors.black),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(date, style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        "عدد الاصلاحات ${numOfTask}",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "$totPrice د.أ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Icon(Icons.arrow_back_ios),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
