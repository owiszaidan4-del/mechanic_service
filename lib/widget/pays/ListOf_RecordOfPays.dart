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
    final dateText = _extractFormattedDate();

    return GestureDetector(
      onTap: () => _navigateToDetails(context, dateText),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 10, color: Colors.black),
          child: Column(children: [_buildHeader(dateText), const Divider()]),
        ),
      ),
    );
  }

  // =========================
  // 🔹 UI Sections
  // =========================

  Widget _buildHeader(String dateText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildLeftSection(dateText), _buildRightSection()],
    );
  }

  Widget _buildLeftSection(String dateText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(dateText, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(
          "عدد الاصلاحات $numOfTask",
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildRightSection() {
    return Row(
      children: [
        Text(
          "$totPrice د.أ",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Icon(Icons.arrow_back_ios),
        ),
      ],
    );
  }

  // =========================
  // 🔹 Navigation
  // =========================

  void _navigateToDetails(BuildContext context, String dateText) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RecordTasks(
          modelOrders: modelOrders,
          date: dateText,
          numOfTask: numOfTask,
          totPrice: totPrice,
        ),
      ),
    );
  }

  // =========================
  // 🔹 Helpers
  // =========================

  String _extractFormattedDate() {
    final Timestamp timestamp = modelOrders.first.timeCompleatedOrder!;
    final DateTime dateTime = timestamp.toDate();

    return DateFormat('EEEE, d MMMM', 'ar').format(dateTime);
  }
}
