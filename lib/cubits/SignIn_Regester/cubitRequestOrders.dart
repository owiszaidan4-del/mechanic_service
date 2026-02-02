import 'dart:developer';

import 'package:car_serves/cubits/SignIn_Regester/stateRequestOrders.dart';
import 'package:car_serves/service/modelOrders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cubitrequestorders extends Cubit<Staterequestorders> {
  Cubitrequestorders() : super(InetialStete());
  requestorders() async {
    FirebaseFirestore.instance
        .collection("orders")
        .where("wating", isEqualTo: true)
        .snapshots()
        .listen((event) {
          log("op");
          List<Modelorders> model = [];
          if (event.docs.isNotEmpty) {
            for (var element in event.docs) {
              model.add(Modelorders.fromJson(element));
            }
            findMechanic(model);
          }
        });
  }

  findMechanic(List<Modelorders> model) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("mechanicOnline")
        .where("available", isEqualTo: true)
        .get();
    if (snapshot.docs.isNotEmpty) {
      final idMechanics = snapshot.docs[0].id;
      log(idMechanics);
    }
  }
}
