import 'dart:async';
import 'dart:developer';

import 'package:car_serves/constant.dart';
import 'package:car_serves/cubits/SignIn_Regester/stateRequestOrders.dart';
import 'package:car_serves/service/modelDriverInfo.dart';
import 'package:car_serves/service/modelOrders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
    try {
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
          }

          modifyOrderStatus(
            idMechanic: id,
            idUser: model[i].id,
            idDocs: event.docs[i].id,
          );
        }
      }
    } catch (e) {
      log(e.toString());
      emit(StateProplem(err: e.toString()));
    }
  }

  modifyOrderStatus({
    required String idMechanic,
    required String idUser,
    required String idDocs,
  }) async {
    try {
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
    } catch (e) {
      emit(StateProplem(err: e.toString()));
    }
  }

  receivingNewRequest({
    required String idMechanic,
    required String idUser,
    required String idDocs,
  }) async {
    await FirebaseFirestore.instance
        .collection("mechanicOnline")
        .doc(idMechanic)
        .update({"available": false});
    final driverInfo = await getDriverInfoAsModel(idUser);

    if (driverInfo != null) {
      log("StateWaiting");
      emit(StateWaiting(modeldriverInfo: driverInfo));
      // Timer.periodic(Duration(minutes: 20), (timer) async {
      //   await checkAndCancelOrder(idDocs: idDocs);
      //   timer.cancel();
      // });
    }
  }

  Future<void> checkAndCancelOrder({required String idDocs}) async {
    final doc = await FirebaseFirestore.instance
        .collection("orders")
        .doc(idDocs)
        .get();

    if (!doc.exists || doc.data() == null) {
      log("nulllllllllllll");
      return;
    }
    ;

    final data = doc.data()!;

    if (data["stateOfRequest"] != "assigend") {
      log("!=assigend");
      return;
    }
    ;

    if (data["timeOfassigend"] == null) {
      log("null timeOfassigend");
      return;
    }

    await FirebaseFirestore.instance.collection("orders").doc(idDocs).update({
      "stateOfRequest": "pending",
    });
    emit(StateRejectOrders());
    Future.delayed(Duration(seconds: 20), () {
      FirebaseFirestore.instance
          .collection("mechanicOnline")
          .doc(currentUser)
          .update({"available": true});
      emit(InetialStete());
    });

    log("❌ تم إلغاء الطلب");
  }

  Future<ModeldriverInfo?> getDriverInfoAsModel(String idUser) async {
    try {
      final data = await FirebaseFirestore.instance
          .collection("users")
          .doc(idUser)
          .get();
      if (data.exists && data.data() != null) {
        final ModeldriverInfo model = ModeldriverInfo.fromJson(data.data()!);
        return model;
      }
    } catch (e) {
      log(e.toString());
      emit(StateProplem(err: e.toString()));
      return null;
    }
  }

  @override
  Future<void> close() {
    _ordersSub?.cancel();
    return super.close();
  }
}
