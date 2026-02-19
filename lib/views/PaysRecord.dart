import 'dart:developer';

import 'package:car_serves/constant.dart';
import 'package:car_serves/service/modelOrders_.dart';
import 'package:car_serves/views/performance.dart';
import 'package:car_serves/widget/pays/ListOf_RecordOfPays.dart';
import 'package:car_serves/widget/pays/Pays_Statment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

class Paysrecord extends StatefulWidget {
  @override
  State<Paysrecord> createState() => _PaysrecordState();
}

class _PaysrecordState extends State<Paysrecord> {
  int count = 1;
  int count2 = 0;

  @override
  Widget build(BuildContext context) {
    Timestamp lastWeekTimestamp = Timestamp.fromDate(
      DateTime.now().subtract(Duration(days: 7 * count)),
    );
    Timestamp nowday = Timestamp.fromDate(
      DateTime.now().subtract(Duration(days: 0 + count2)),
    );
    final Stream<QuerySnapshot> paysStream = FirebaseFirestore.instance
        .collection("orders")
        .where("idMecanic", isEqualTo: currentUser)
        .where(
          'timeCompleatedOrder',
          isGreaterThan: lastWeekTimestamp,
          isLessThanOrEqualTo: nowday,
        )
        .orderBy("timeCompleatedOrder", descending: true)
        .snapshots();

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("الدفعات"), centerTitle: true),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: StreamBuilder(
          stream: paysStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              log("snapshot.error.toString()");
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("Loading..."));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Column(
                children: [
                  Left_Right_Button(
                    text: "لا يوجد دفعات لهذا الاسبوع",
                    onTapRight: () {},
                    onTapLeft: () {
                      setState(() {
                        count--;
                        count2 -= 7;
                      });
                    },
                  ),
                ],
              );
            }

            ///

            Map<String, List<modelOrders_>> groupedOrders = {};
            final docs = snapshot.data!.docs;
            for (var element in docs) {
              final order = modelOrders_.fromJson(
                element.data() as Map<String, dynamic>,
              );
              final Timestamp timestamp = order.timeCompleatedOrder!;
              final DateTime dateTime = timestamp.toDate();
              final dateCompleatOrder = DateFormat(
                'EEEE, d MMMM',
                'ar',
              ).format(dateTime);
              final key = dateCompleatOrder;
              if (!groupedOrders.containsKey(key)) {
                groupedOrders[dateCompleatOrder] = [];
              }

              groupedOrders[key]!.add(order);
            }
            /////
            return Column(
              spacing: 20,
              children: [
                Left_Right_Button(
                  text: "الاسبوع",
                  onTapRight: () {
                    setState(() {
                      count++;
                      count2 += 7;
                    });
                  },
                  onTapLeft: () {
                    if (count != 1 && count2 != 0) {
                      setState(() {
                        count--;
                        count2 -= 7;
                      });
                    }
                  },
                ),
                Pays_Statment(),
                Divider(height: 20, thickness: 2, color: Colors.black),
                SizedBox(
                  height: height * 0.4,
                  child: ListView.builder(
                    itemCount: groupedOrders.length,
                    itemBuilder: (context, index) {
                      final entry = groupedOrders.entries
                          .elementAt(index)
                          .value;

                      return ListOf_RecordOfPays(
                        modelOrders: entry,
                        numOfTask: entry.length,
                        totPrice: "30",
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
