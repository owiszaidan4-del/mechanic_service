import 'dart:developer';
import 'dart:ffi';

import 'package:car_serves/constant.dart';
import 'package:car_serves/service/modelOrders_.dart';
import 'package:flutter/material.dart';

class Pays_Statment extends StatelessWidget {
  const Pays_Statment({
    super.key,
    required this.groupedOrders,
    required this.listDate,
  });
  final Map<String, List<modelOrders_>> groupedOrders;
  final List<String> listDate;
  @override
  Widget build(BuildContext context) {
    List<int> numHoursWork = calcSumHoursWork(groupedOrders: groupedOrders);
    String sumSalarYInWeek = calcSumSalaryInWeek(groupedOrders: groupedOrders);
    double salary = double.parse(sumSalarYInWeek);
    double totalHours = numHoursWork[0] + (numHoursWork[1] / 60);

    double avgPerHour = totalHours == 0 ? 0 : salary / totalHours;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.white),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.17,
          decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(colors: colors),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                blurStyle: BlurStyle.outer,
                color: Colors.black,
                offset: Offset(0.5, 0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage("asset/money-bag.png"),

                  width: 30,
                  height: 30,
                ),
                SizedBox(width: 20),
                Column(
                  children: [
                    DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      child: DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                        child: Row(
                          children: [
                            Text(listDate[0]),
                            Text("-"),
                            Text(listDate[listDate.length - 1]),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        "$sumSalarYInWeek د.أ",
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DefaultTextStyle(
                      style: TextStyle(fontSize: 8, color: Colors.black),
                      child: Expanded(
                        child: Row(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text("المتوسط في الساعة   "),
                                Text(
                                  "${avgPerHour.toStringAsFixed(3)} د.أ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text("ساعات العمل"),
                                Text(
                                  "${numHoursWork[0]}:${numHoursWork[1]} س",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String calcSumSalaryInWeek({
    required Map<String, List<modelOrders_>> groupedOrders,
  }) {
    double sum = 0;
    for (int i = 0; i < groupedOrders.length; i++) {
      for (int j = 0; j < groupedOrders.values.elementAt(i).length; j++) {
        sum += groupedOrders.values.elementAt(i).elementAt(j).wages;
      }
    }

    return sum.toStringAsFixed(3);
  }

  List<int> calcSumHoursWork({
    required Map<String, List<modelOrders_>> groupedOrders,
  }) {
    int sum = 0;
    for (var orders in groupedOrders.values) {
      for (var order in orders) {
        DateTime? dateAsign = order.timeOfassigend?.toDate();
        DateTime? dateCompleted = order.timeCompleatedOrder?.toDate();
        if (dateAsign != null && dateCompleted != null) {
          Duration diff = dateCompleted.difference(dateAsign);
          log(diff.inHours.toString());
          if (!diff.isNegative) {
            sum += diff.inMinutes;
            log("Assigned: $dateAsign");
            log("Completed: $dateCompleted");
            log("Diff: ${diff.toString()}");
            log("Minutes: ${diff.inMinutes}");
            log("Seconds: ${diff.inSeconds}");
          }
        } else {
          log("message");
        }
      }
    }
    Duration dur = Duration(minutes: sum);
    int minutes = dur.inMinutes.remainder(60);
    int hours = dur.inHours;
    List<int> list = [hours, minutes];

    return list;
  }
}
