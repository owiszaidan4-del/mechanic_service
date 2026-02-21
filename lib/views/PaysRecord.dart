import 'dart:developer';

import 'package:car_serves/constant.dart';
import 'package:car_serves/service/modelOrders_.dart';
import 'package:car_serves/views/performance.dart';
import 'package:car_serves/widget/pays/ListOf_RecordOfPays.dart';
import 'package:car_serves/widget/pays/Pays_Statment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

class Paysrecord extends StatefulWidget {
  const Paysrecord({super.key});

  @override
  State<Paysrecord> createState() => _PaysrecordState();
}

class _PaysrecordState extends State<Paysrecord> {
  int _weekIndex = 1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dateRange = _calculateWeekRange();
    final paysStream = _buildPaysStream(dateRange);

    return Scaffold(
      appBar: AppBar(title: const Text("الدفعات"), centerTitle: true),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: StreamBuilder<QuerySnapshot>(
          stream: paysStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              log(snapshot.error.toString());
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text("Loading..."));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Column(
                children: [
                  _buildWeekSwitcher(text: "لا يوجد دفعات لهذا الاسبوع"),
                ],
              );
            }

            final groupedOrders = _groupOrdersByDay(snapshot.data!.docs);

            return Column(
              children: [
                const SizedBox(height: 20),
                _buildWeekSwitcher(text: "الاسبوع"),
                const SizedBox(height: 20),
                Pays_Statment(
                  listDate: groupedOrders.keys.toList(),
                  groupedOrders: groupedOrders,
                ),
                const Divider(height: 20, thickness: 2),
                SizedBox(
                  height: size.height * 0.4,
                  child: ListView.builder(
                    itemCount: groupedOrders.length,
                    itemBuilder: (context, index) {
                      final orders = groupedOrders.entries
                          .elementAt(index)
                          .value;

                      return ListOf_RecordOfPays(
                        modelOrders: orders,
                        numOfTask: orders.length,
                        totPrice: _calculateWagesInDay(orders).toString(),
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

  // =========================
  // 🔹 Firestore Stream
  // =========================

  Stream<QuerySnapshot> _buildPaysStream(
    ({DateTime start, DateTime end}) range,
  ) {
    return FirebaseFirestore.instance
        .collection("orders")
        .where("idMecanic", isEqualTo: currentUser)
        .where(
          'timeCompleatedOrder',
          isGreaterThanOrEqualTo: Timestamp.fromDate(range.start),
        )
        .where('timeCompleatedOrder', isLessThan: Timestamp.fromDate(range.end))
        .orderBy("timeCompleatedOrder", descending: true)
        .snapshots();
  }

  // =========================
  // 🔹 Week Calculation
  // =========================

  ({DateTime start, DateTime end}) _calculateWeekRange() {
    final now = DateTime.now();
    final startOfCurrentWeek = now.subtract(Duration(days: now.weekday - 1));

    final startWeek = DateTime(
      startOfCurrentWeek.year,
      startOfCurrentWeek.month,
      startOfCurrentWeek.day,
    ).subtract(Duration(days: 7 * (_weekIndex - 1)));

    final endWeek = startWeek.add(const Duration(days: 7));

    return (start: startWeek, end: endWeek);
  }

  // =========================
  // 🔹 Group Orders
  // =========================

  Map<String, List<modelOrders_>> _groupOrdersByDay(
    List<QueryDocumentSnapshot> docs,
  ) {
    final Map<String, List<modelOrders_>> grouped = {};

    for (var doc in docs) {
      final order = modelOrders_.fromJson(doc.data() as Map<String, dynamic>);

      final date = order.timeCompleatedOrder!.toDate();
      final formattedDate = DateFormat('EEEE, d MMMM', 'ar').format(date);

      grouped.putIfAbsent(formattedDate, () => []);
      grouped[formattedDate]!.add(order);
    }

    return grouped;
  }

  // =========================
  // 🔹 Week Switch Widget
  // =========================

  Widget _buildWeekSwitcher({required String text}) {
    return Left_Right_Button(
      text: text,
      onTapRight: () {
        setState(() => _weekIndex++);
      },
      onTapLeft: () {
        if (_weekIndex != 1) {
          setState(() => _weekIndex--);
        }
      },
    );
  }

  // =========================
  // 🔹 Wage Calculation
  // =========================

  double _calculateWagesInDay(List<modelOrders_> ordersDay) {
    double sum = 0;
    for (var order in ordersDay) {
      sum += order.wages;
    }
    return sum;
  }
}
