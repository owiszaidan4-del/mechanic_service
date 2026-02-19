import 'package:car_serves/constant.dart';
import 'package:car_serves/service/modelOrders_.dart';
import 'package:car_serves/widget/RcordsOfTasks/RecordOfTasks_ListOfRecordsOfTasks.dart';
import 'package:car_serves/widget/RcordsOfTasks/RecordTasks_DoubleFrame_Compleate.dart';
import 'package:car_serves/widget/RcordsOfTasks/RecordTasks_DoubleFrame_unCompleate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecordTasks extends StatelessWidget {
  const RecordTasks({
    required this.date,
    required this.numOfTask,
    required this.totPrice,
    required this.modelOrders,
  });
  final String date;
  final List<modelOrders_> modelOrders;
  final int numOfTask;
  final String totPrice;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("سجل المهام", style: TextStyle(fontSize: 15)),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    date,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Text(
                "اجمالي المبالغ المكتسبة",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "$totPrice د.أ",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
              Text(
                "المهام",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  spacing: 10,
                  children: [
                    RecordTasks_DoubleFrame_Compleate(
                      numOfTask: numOfTask.toString(),
                    ),
                    RecordTasks_DoubleFrame_unCompleate(
                      width: width,
                      numOfTask: 0.toString(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.6,
                child: ListView.builder(
                  itemCount: modelOrders.length,
                  itemBuilder: (context, index) {
                    return RecordOfTasks_ListOfRecordsOfTasks(
                      modelorder: modelOrders[index],

                      totPrice: totPrice,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
