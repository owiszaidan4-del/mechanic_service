import 'dart:developer';

import 'package:car_serves/constant.dart';
import 'package:car_serves/service/modelDriverInfo.dart';
import 'package:car_serves/service/modelOrders_.dart';
import 'package:car_serves/widget/RcordsOfTasks/personInfo_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

class RecordOfTasks_ListOfRecordsOfTasks extends StatelessWidget {
  const RecordOfTasks_ListOfRecordsOfTasks({
    super.key,

    required this.totPrice,
    required this.modelorder,
  });

  final String totPrice;
  final modelOrders_ modelorder;
  @override
  Widget build(BuildContext context) {
    final DateTime dateTime = modelorder.timeCompleatedOrder!.toDate();
    final formatEndTime = DateFormat.Hm().format(dateTime).toString();
    final DateTime dateTime2 = modelorder.timeOfassigend!.toDate();
    final formatBeginTime = DateFormat.Hm().format(dateTime2).toString();
    log("$formatBeginTime-$formatEndTime");
    final endFormating = '$formatBeginTime - $formatEndTime';
    final ref = FirebaseFirestore.instance
        .collection("users")
        .doc(modelorder.id)
        .get();
    return FutureBuilder(
      future: ref,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasError) {
          log(asyncSnapshot.error.toString());
          return Center(child: Text("حدث خطا ما ......"));
        }
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return Text("جاري التحميل....");
        }
        if (asyncSnapshot.data == null) {
          return Text("لايوجد بيانات ....");
        }
        final ModeldriverInfo modeldriverInfo = ModeldriverInfo.fromJson(
          asyncSnapshot.data!.data()!,
        );
        return GestureDetector(
          onTap: () {
            final DateTime dateTime = modelorder.timeCompleatedOrder!.toDate();
            final formatEndTime = DateFormat.Hm().format(dateTime).toString();
            final DateTime dateTime2 = modelorder.timeOfassigend!.toDate();
            final formatBeginTime = DateFormat.Hm()
                .format(dateTime2)
                .toString();
            log("$formatBeginTime-$formatEndTime");
            final endFormating = '$formatBeginTime - $formatEndTime';
            showDialog(
              context: context,
              builder: (context) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: AlertDialog(
                    backgroundColor: Colors.black.withOpacity(0.0),
                    content: personInfo_card(
                      name: modeldriverInfo.full_name,
                      phoneNumber: modeldriverInfo.phoneNumber,
                      proplemVechel: modelorder.descreption,
                    ),
                  ),
                );
              },
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  blurStyle: BlurStyle.outer,
                  color: Colors.black,
                ),
              ],
              gradient: LinearGradient(colors: colors),
              color: Colors.white.withOpacity(0.7),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          modeldriverInfo.careModel,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          endFormating,
                          style: TextStyle(fontSize: 10, color: Colors.black),
                        ),
                        Text(
                          modeldriverInfo.carId,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("$totPrice د.أ "),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Icon(Icons.arrow_back_ios),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
