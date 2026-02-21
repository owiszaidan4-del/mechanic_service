import 'dart:developer';

import 'package:car_serves/constant.dart';
import 'package:car_serves/service/modelDriverInfo.dart';
import 'package:car_serves/service/modelOrders_.dart';
import 'package:car_serves/widget/RcordsOfTasks/personInfo_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    final endFormatting = _getFormattedTimeRange();

    final userFuture = FirebaseFirestore.instance
        .collection("users")
        .doc(modelorder.id)
        .get();

    return FutureBuilder<DocumentSnapshot>(
      future: userFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          log(snapshot.error.toString());
          return const Center(child: Text("حدث خطأ ما ......"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("جاري التحميل....");
        }
        if (snapshot.data?.data() == null) {
          return const Text("لا يوجد بيانات ....");
        }

        final modeldriverInfo = ModeldriverInfo.fromJson(
          snapshot.data!.data()! as Map<String, dynamic>,
        );

        return _buildTaskCard(context, modeldriverInfo, endFormatting);
      },
    );
  }

  // =========================
  // 🔹 Helpers
  // =========================

  String _getFormattedTimeRange() {
    final DateTime startTime = modelorder.timeOfassigend!.toDate();
    final DateTime endTime = modelorder.timeCompleatedOrder!.toDate();

    final formatStart = DateFormat.Hm().format(startTime);
    final formatEnd = DateFormat.Hm().format(endTime);

    log("$formatStart-$formatEnd");

    return '$formatStart - $formatEnd';
  }

  // =========================
  // 🔹 UI Card
  // =========================

  Widget _buildTaskCard(
    BuildContext context,
    ModeldriverInfo driverInfo,
    String timeRange,
  ) {
    return GestureDetector(
      onTap: () => _showDriverInfoDialog(context, driverInfo),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              blurStyle: BlurStyle.outer,
              color: Colors.black,
            ),
          ],
          gradient: LinearGradient(colors: colors),
          color: Colors.white.withOpacity(0.7),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildDriverInfoColumn(driverInfo, timeRange),
              _buildPriceSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDriverInfoColumn(ModeldriverInfo driverInfo, String timeRange) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          driverInfo.careModel,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          timeRange,
          style: const TextStyle(fontSize: 10, color: Colors.black),
        ),
        Text(
          driverInfo.carId,
          style: TextStyle(fontSize: 10, color: Colors.black.withOpacity(0.3)),
        ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Row(
      children: [
        Text("$totPrice د.أ "),
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Icon(Icons.arrow_back_ios),
        ),
      ],
    );
  }

  // =========================
  // 🔹 Dialog
  // =========================

  void _showDriverInfoDialog(BuildContext context, ModeldriverInfo driverInfo) {
    showDialog(
      context: context,
      builder: (_) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: Colors.black.withOpacity(0.0),
            content: personInfo_card(
              name: driverInfo.full_name,
              phoneNumber: driverInfo.phoneNumber,
              proplemVechel: modelorder.descreption,
            ),
          ),
        );
      },
    );
  }
}
