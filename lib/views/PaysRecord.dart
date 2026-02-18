import 'dart:developer';

import 'package:car_serves/constant.dart';
import 'package:car_serves/service/modelOrders_.dart';
import 'package:car_serves/views/performance.dart';
import 'package:car_serves/widget/pays/ListOf_RecordOfPays.dart';
import 'package:car_serves/widget/pays/Pays_Statment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Paysrecord extends StatefulWidget {
  @override
  State<Paysrecord> createState() => _PaysrecordState();
}

class _PaysrecordState extends State<Paysrecord> {
  final Stream<QuerySnapshot> paysStream = FirebaseFirestore.instance
      .collection("orders")
      .where("idMecanic", isEqualTo: currentUser)
      .snapshots();
  @override
  Widget build(BuildContext context) {
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
              log(snapshot.error.toString());
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("Loading..."));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Text("لايوجد سجل دفعات لغاية الان");
            }

            ///

            Map<String, List<modelOrders_>> groupedOrders = {};
            final docs = snapshot.data!.docs;
            for (var element in docs) {
              final order = modelOrders_.fromJson(
                element.data() as Map<String, dynamic>,
              );

              final key = order.timeCompleatedOrder;
              if (!groupedOrders.containsKey(key)) {
                groupedOrders[key] = [];
              }

              groupedOrders[key]!.add(order);
            }
            /////
            return Column(
              spacing: 20,
              children: [
                Left_Right_Button(text: "هذا الاسبوع"),
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
                        date: entry[index].timeCompleatedOrder,
                        numOfTask: entry.length.toString(),
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
