import 'dart:async';
import 'dart:developer';

import 'package:car_serves/constant.dart';
import 'package:car_serves/cubits/SignIn_Regester/stateGetStateOfWork.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cubitgetstateofwork extends Cubit<Stategetstateofwork> {
  Cubitgetstateofwork() : super(InitState());

  StreamSubscription<DocumentSnapshot>? _subscription;
  getstateofwork() {
    try {
      _subscription?.cancel();
      _subscription = FirebaseFirestore.instance
          .collection("mechanicOnline")
          .doc(currentUser)
          .snapshots()
          .listen((event) {
            if (event.exists && event.data() != null) {
              final bool stateofwork = event.data()!["stateOfWork"];
              final bool available = event.data()!["available"];

              emit(
                StateSucssesgetstateOfWork(
                  stateOfWork: stateofwork,
                  available: available,
                ),
              );
            } else {
              log("error in get firebase info");
              emit(
                StatefaieldgetstateOfWork(err: "error in get firebase info"),
              );
            }
          });
    } catch (e) {
      log(e.toString());
      emit(StatefaieldgetstateOfWork(err: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
