import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:car_serves/constant.dart';
import 'package:car_serves/cubits/SignIn_Regester/States_RegesterAuthTransaction.dart';
import 'package:car_serves/cubits/SignIn_Regester/stateGetAll_infoUsers.dart';
import 'package:car_serves/service/modelGetAllUserInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

class cubitGetAll__infoUsers extends Cubit<StategetallInfousers> {
  cubitGetAll__infoUsers() : super(InetialState());
  getAllinfoUsers() async {
    emit(StateLoad());
    final DocumentSnapshot<Map<String, dynamic>> info = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(currentUser)
        .get();
    try {
      if (info.exists && info.data() != null) {
        Modelgetalluserinfo model = Modelgetalluserinfo.fromJson(info.data()!);
        emit(StateSucsess(allInfoUsers: model));
      } else {
        emit(StateFaield(errType: "لايوجد مستخدم"));
      }
    } catch (e) {
      emit(StateFaield(errType: e.toString()));
    }
  }
}
