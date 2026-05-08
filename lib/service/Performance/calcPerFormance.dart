import 'dart:math';

import 'package:car_serves/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Calcperformance {
  final int acceptedCount;
  final int cancelledCount;
  final int completedCount;
  final int totalRequests;
  final int totalWorkMinutes;
  const Calcperformance({
    required this.acceptedCount,
    required this.cancelledCount,
    required this.completedCount,
    required this.totalRequests,
    required this.totalWorkMinutes,
  });
  calcPerformance() {
    final completedW = 0.4;
    final workMinutesW = 0.2;
    final avgAcceptedOrderW = 0.3;
    final cancelOrderW = 0.1;
    final completedScore = min((completedCount / 20), 1) * 100;
    final avgAcceptedOrderScore = avgAcceptedOrder();
    final totalWorkMinutesScore = min((totalWorkMinutes / 1200), 1) * 100;
    final cancelOrderScore = min((cancelledCount / 10), 1) * 100;
    final totScore =
        ((completedScore * completedW) +
            (totalWorkMinutesScore * workMinutesW) +
            (avgAcceptedOrderScore * avgAcceptedOrderW)) -
        (cancelOrderScore * cancelOrderW);
    FirebaseFirestore.instance.collection("users").doc(currentUser).update({
      "performance": totScore.clamp(0, 100),
    });
    return totScore.clamp(0, 100).round();
  }

  double avgAcceptedOrder() {
    if (totalRequests == 0) {
      return 100.0;
    }
    final avg = ((acceptedCount) / totalRequests) * 100;
    return avg.abs();
  }

  String workHours() {
    final hours = totalWorkMinutes ~/ 60;
    final minutes = totalWorkMinutes % 60;
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
  }
}
