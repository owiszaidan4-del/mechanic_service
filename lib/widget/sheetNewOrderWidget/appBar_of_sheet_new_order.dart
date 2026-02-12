import 'package:car_serves/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class appBar_of_sheet_new_order extends StatelessWidget {
  const appBar_of_sheet_new_order({super.key, required this.idDoc});
  final String idDoc;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await FirebaseFirestore.instance.collection("orders").doc(idDoc).update(
          {"stateOfRequest": "accepted"},
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        margin: EdgeInsets.only(bottom: 8),
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: colors),
        ),
        child: Text("قبول الطلب", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
