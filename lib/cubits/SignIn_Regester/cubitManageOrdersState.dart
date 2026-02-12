import 'package:bloc/bloc.dart';
import 'package:car_serves/constant.dart';
import 'package:car_serves/cubits/SignIn_Regester/StateManageOrdersState.dart';
import 'package:car_serves/service/modelDriverInfo.dart';
import 'package:car_serves/service/modelOrders_.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cubitmanageordersstate extends Cubit<Statemanageordersstate> {
  Cubitmanageordersstate() : super(InetialStete());
  manageStateOfOrders() async {
    FirebaseFirestore.instance
        .collection("orders")
        .where("stateOfRequest", whereIn: ["assigend", "accepted"])
        .where("idMecanic", isEqualTo: currentUser)
        .snapshots()
        .listen((event) async {
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
                emit(
                  StateAcceptOrders(
                    modeldriverInfo: modeldriverInfo,
                    modelorders: modelorders,
                  ),
                );
              }
            }
          }
        });
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
