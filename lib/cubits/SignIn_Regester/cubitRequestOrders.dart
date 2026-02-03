import 'dart:async';
import 'dart:developer';

import 'package:car_serves/constant.dart';
import 'package:car_serves/cubits/SignIn_Regester/stateRequestOrders.dart';
import 'package:car_serves/service/modelOrders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class Cubitrequestorders extends Cubit<Staterequestorders> {
  Cubitrequestorders() : super(InetialStete());
  StreamSubscription? _ordersSub;
  requestorders() async {
    emit(InetialStete());
    _ordersSub?.cancel();
    _ordersSub = FirebaseFirestore.instance
        .collection("orders")
        .where("stateOfRequest", isEqualTo: "pending")
        .orderBy("timeOrder", descending: false)
        .snapshots()
        .listen((event) {
          log("op");
          List<Modelorders> model = [];
          if (event.docs.isNotEmpty) {
            for (var element in event.docs) {
              model.add(Modelorders.fromJson(element));
            }
            findMechanic(model, event);
          }
        });
  }

  findMechanic(
    List<Modelorders> model,
    QuerySnapshot<Map<String, dynamic>> event,
  ) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("mechanicOnline")
        .where("available", isEqualTo: true)
        .get();
    if (snapshot.docs.isNotEmpty) {
      final data = snapshot.docs;
      double mindistance = double.infinity;

      String id = "";
      for (int i = 0; i < model.length; i++) {
        for (int j = 0; j < data.length; j++) {
          double distance = Geolocator.distanceBetween(
            data[j]["lat"],
            data[j]["lng"],
            model[i].lat,
            model[i].lng,
          );
          if (mindistance >= distance) {
            mindistance = distance;
            id = snapshot.docs[j].id;
          }
          modifyOrderStatus(
            idMechanic: id,
            idUser: model[i].id,
            idDocs: event.docs[i].id,
          );
        }
      }
    }
  }

  modifyOrderStatus({
    required String idMechanic,
    required String idUser,
    required String idDocs,
  }) async {
    await FirebaseFirestore.instance.collection("orders").doc(idDocs).set({
      "idMecanic": idMechanic,
      "stateOfRequest": "assigend",
      "timeOfassigend": FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    if (idMechanic == currentUser) {
      receivingNewRequest(
        idDocs: idDocs,
        idMechanic: idMechanic,
        idUser: idUser,
      );
    }
  }

  receivingNewRequest({
    required String idMechanic,
    required String idUser,
    required String idDocs,
  }) {
    FirebaseFirestore.instance.collection("users").doc(idUser).get();
  }

  @override
  Future<void> close() {
    _ordersSub?.cancel();
    return super.close();
  }
}
