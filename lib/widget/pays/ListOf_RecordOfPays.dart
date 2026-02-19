import 'dart:convert';

import 'package:car_serves/service/modelOrders_.dart';
import 'package:car_serves/views/RecordTasks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

class ListOf_RecordOfPays extends StatelessWidget {
  const ListOf_RecordOfPays({
    super.key,
    required this.modelOrders,
    required this.numOfTask,
    required this.totPrice,
  });
  final List<modelOrders_> modelOrders;
  final int numOfTask;

  final String totPrice;
  @override
  Widget build(BuildContext context) {
    final Timestamp timestamp = modelOrders.first.timeCompleatedOrder!;
    final DateTime dateTime = timestamp.toDate();
    final dateCompleatOrder = DateFormat('EEEE, d MMMM', 'ar').format(dateTime);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecordTasks(
              modelOrders: modelOrders,
              date: dateCompleatOrder,
              numOfTask: numOfTask,
              totPrice: totPrice.toString(),
            ),
          ),
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
                      Text(
                        dateCompleatOrder,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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
