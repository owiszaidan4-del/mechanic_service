import 'dart:async';
import 'dart:developer';

import 'package:car_serves/constant.dart';
import 'package:car_serves/cubits/SignIn_Regester/stateRequestOrders.dart';
import 'package:car_serves/service/getArrivalTime.dart';
import 'package:car_serves/service/modelDriverInfo.dart';
import 'package:car_serves/service/modelOrders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Cubitrequestorders extends Cubit {
  double distanceToDriver = 0;
  List<double> latLngMech = [];
  List<double> latLngDriver = [];

  Cubitrequestorders() : super(());
  StreamSubscription? _ordersSub;
  requestorders() async {
    _ordersSub?.cancel();
    _ordersSub = FirebaseFirestore.instance
        .collection("orders")
        .where("stateOfRequest", isEqualTo: "pending")
        .orderBy("timeOrder", descending: false)
        .snapshots()
        .listen((event) {
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

        for (int i = 0; i < model.length; i++) {
          double mindistance = double.infinity;
          String id = "";
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
              latLngMech = [data[j]["lng"], data[j]["lat"]];
            }
          }
          distanceToDriver = mindistance;

          modifyOrderStatus(
            idMechanic: id,
            modelOrder: model[i],
            idDocs: event.docs[i].id,
          );
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  modifyOrderStatus({
    required Modelorders modelOrder,
    required String idMechanic,

    required String idDocs,
  }) async {
    try {
      // await FirebaseFirestore.instance.collection("orders").doc(idDocs).set({
      // "idMecanic": idMechanic,
      // "stateOfRequest": "assigend",
      // "timeOfassigend": FieldValue.serverTimestamp(),
      // }, SetOptions(merge: true));
      if (idMechanic == currentUser) {
        receivingNewRequest(
          modelOrder: modelOrder,
          idDocs: idDocs,
          idMechanic: idMechanic,
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }

  receivingNewRequest({
    required Modelorders modelOrder,
    required String idMechanic,

    required String idDocs,
  }) async {
    await FirebaseFirestore.instance
        .collection("mechanicOnline")
        .doc(idMechanic)
        .update({"available": false});
    final driverInfo = await getDriverInfoAsModel(modelOrder.id);
    latLngDriver = [modelOrder.lng, modelOrder.lat];
    final getarrivaltime = await Getarrivaltime(
      latLngDriver: latLngDriver,
      latLngMech: latLngMech,
    ).getarrivaltime();
    final getplacemark = await placemarkFromCoordinates(
      modelOrder.lat,
      modelOrder.lng,
    );

    final placemark = getplacemark.first;
    if (driverInfo != null) {
      log("StateWaiting");
      await FirebaseFirestore.instance.collection("orders").doc(idDocs).set({
        "idMecanic": idMechanic,
        "stateOfRequest": "assigend",
        "timeOfassigend": FieldValue.serverTimestamp(),
        "placemark": "${placemark.subLocality}, ${placemark.street}",
        "arrivaltime": getarrivaltime,
        "distanceToDriver": distanceToDriver,
      }, SetOptions(merge: true));

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
    log("reject order");
    Future.delayed(Duration(seconds: 20), () {
      FirebaseFirestore.instance
          .collection("mechanicOnline")
          .doc(currentUser)
          .update({"available": true});
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

      return null;
    }
  }

  @override
  Future<void> close() {
    _ordersSub?.cancel();
    return super.close();
  }
}
