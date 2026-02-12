import 'package:car_serves/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AppbarOfSheetAcceptedOrder extends StatelessWidget {
  const AppbarOfSheetAcceptedOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      margin: EdgeInsets.only(bottom: 8),
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.green,
      ),
      child: Text("تم قبول الطلب", style: TextStyle(color: Colors.white)),
    );
  }
}
