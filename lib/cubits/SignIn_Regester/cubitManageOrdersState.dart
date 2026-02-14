import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:car_serves/constant.dart';
import 'package:car_serves/cubits/SignIn_Regester/StateManageOrdersState.dart';
import 'package:car_serves/service/getArrivalTime.dart';
import 'package:car_serves/service/modelDriverInfo.dart';
import 'package:car_serves/service/modelOrders_.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';

class Cubitmanageordersstate extends Cubit<Statemanageordersstate> {
  Cubitmanageordersstate() : super(InetialStete());
  StreamSubscription? _ordersSub;
  StreamSubscription? _distanceSub;
  manageStateOfOrders() async {
    _ordersSub?.cancel();
    _ordersSub = FirebaseFirestore.instance
        .collection("orders")
        .where("stateOfRequest", whereIn: ["assigend", "accepted", "arrived"])
        .where("idMecanic", isEqualTo: currentUser)
        .snapshots()
        .listen((event) async {
          _distanceSub?.cancel();
          if (event.docs.isNotEmpty) {
            final orderInfo = event.docs.first;
            if (orderInfo.data()["stateOfRequest"] == "assigend") {
              final modelOrders_ modelorders = modelOrders_.fromJson(
                event.docs.first.data(),
              );
              final ModeldriverInfo? modeldriverInfo =
                  await getDriverInfoAsModel(modelorders.id);
              final idDoc = event.docs.first.id;
              if (modeldriverInfo != null) {
                emit(
                  StateWaiting(
                    modeldriverInfo: modeldriverInfo,
                    modelorders: modelorders,
                    idDoc: idDoc,
                  ),
                );
              }
            } else if (orderInfo.data()["stateOfRequest"] == "accepted") {
              final modelOrders_ modelorders = modelOrders_.fromJson(
                event.docs.first.data(),
              );
              final ModeldriverInfo? modeldriverInfo =
                  await getDriverInfoAsModel(modelorders.id);
              final idDoc = event.docs.first.id;
              if (modeldriverInfo != null) {
                await update_Distance_ArivalTime(
                  lat: modelorders.lat,
                  lng: modelorders.lng,
                  idDoc: idDoc,
                );
                emit(
                  StateAcceptOrders(
                    idDoc: idDoc,
                    modeldriverInfo: modeldriverInfo,
                    modelorders: modelorders,
                  ),
                );
              }
            } else if (orderInfo.data()["stateOfRequest"] == "arrived") {
              final modelOrders_ modelorders = modelOrders_.fromJson(
                event.docs.first.data(),
              );
              final ModeldriverInfo? modeldriverInfo =
                  await getDriverInfoAsModel(modelorders.id);
              final idDoc = event.docs.first.id;
              if (modeldriverInfo != null) {
                emit(
                  StateArrived(
                    idDoc: idDoc,
                    modeldriverInfo: modeldriverInfo,
                    modelorders: modelorders,
                  ),
                );
              }
            }
          }
        });
  }

  update_Distance_ArivalTime({
    required double lat,
    required double lng,
    required idDoc,
  }) async {
    _distanceSub?.cancel();
    _distanceSub = FirebaseFirestore.instance
        .collection("mechanicOnline")
        .doc(currentUser)
        .snapshots()
        .listen((event) async {
          if (event.exists) {
            final data = event.data();
            if (data != null) {
              double distance = Geolocator.distanceBetween(
                data["lat"],
                data["lng"],
                lat,
                lng,
              );
              List<double> lngLatMech = [data["lng"], data["lat"]];
              List<double> lngLatDriver = [lng, lat];
              double arrivalTime = await Getarrivaltime(
                lngLatMech: lngLatMech,
                lngLatDriver: lngLatDriver,
              ).getarrivaltime();
              FirebaseFirestore.instance.collection("orders").doc(idDoc).update(
                {"distanceToDriver": distance, "arrivaltime": arrivalTime},
              );
              if (distance < 50) {
                await FirebaseFirestore.instance
                    .collection("orders")
                    .doc(idDoc)
                    .update({"stateOfRequest": "arrived"});
              }
            }
          }
        });
  }

  @override
  Future<void> close() {
    _ordersSub?.cancel();
    _distanceSub?.cancel();
    return super.close();
  }
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
    // log(e.toString());
    // emit(StateProplem(err: e.toString()));
    return null;
  }
}
