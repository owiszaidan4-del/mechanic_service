import 'package:car_serves/service/modelOrders_.dart';
import 'package:car_serves/widget/RcordsOfTasks/RecordOfTasks_ListOfRecordsOfTasks.dart';
import 'package:car_serves/widget/RcordsOfTasks/RecordTasks_DoubleFrame_Compleate.dart';
import 'package:car_serves/widget/RcordsOfTasks/RecordTasks_DoubleFrame_unCompleate.dart';
import 'package:flutter/material.dart';

class RecordTasks extends StatelessWidget {
  const RecordTasks({
    super.key,
    required this.date,
    required this.numOfTask,
    required this.totPrice,
    required this.modelOrders,
  });

  final String date;
  final List<modelOrders_> modelOrders;
  final int numOfTask;
  final String totPrice;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("سجل المهام", style: TextStyle(fontSize: 15)),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDateHeader(),
              _buildTotalEarnings(),
              const Divider(),
              const Text(
                "المهام",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildTasksSummary(size.width),
              const SizedBox(height: 8),
              _buildTasksList(size.height),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // 🔹 UI Sections
  // =========================

  Widget _buildDateHeader() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(date, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildTotalEarnings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "اجمالي المبالغ المكتسبة",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "$totPrice د.أ",
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTasksSummary(double width) {
    return Row(
      children: [
        RecordTasks_DoubleFrame_Compleate(numOfTask: numOfTask.toString()),
        const SizedBox(width: 10),
        RecordTasks_DoubleFrame_unCompleate(width: width, numOfTask: '0'),
      ],
    );
  }

  Widget _buildTasksList(double height) {
    return SizedBox(
      height: height * 0.6,
      child: ListView.builder(
        itemCount: modelOrders.length,
        itemBuilder: (context, index) {
          final order = modelOrders[index];
          return RecordOfTasks_ListOfRecordsOfTasks(
            modelorder: order,
            totPrice: order.wages.toString(),
          );
        },
      ),
    );
  }
}
