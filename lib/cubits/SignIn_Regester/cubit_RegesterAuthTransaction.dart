import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:car_serves/constant.dart';
import 'package:car_serves/cubits/SignIn_Regester/States_RegesterAuthTransaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CubitRegesterauthtransaction
    extends Cubit<StatesRegesterauthtransaction> {
  CubitRegesterauthtransaction() : super(state_Inetial());
  String? email;
  String? password;
  String? phoneNumber;
  String? confirmPassword;
  String? fullName;
  String? workShopName;
  String? specialization;

  String? workadress;

  String? city;
  String? area;

  sendRegesterInfo({
    required email,
    required password,
    required phoneNumber,
    required confirmPassword,
    required fullName,
    required workShopName,
    required workadress,
    required city,
    required area,
    required specialization,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      emit(state_success());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(state_failed(typeFailed: 'The password provided is too weak.'));
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        emit(
          state_failed(
            typeFailed: 'The account already exists for that email.',
          ),
        );
        log('The account already exists for that email.');
        return;
      }
    } catch (e) {
      emit(state_failed(typeFailed: e.toString()));
      log(e.toString());
      return;
    }
    //fireStore
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Call the user's CollectionReference to add a new user
    return users
        .doc(currentUser)
        .set({
          'roule': 'mecanic',
          'full_name': fullName,
          'phoneNumber': phoneNumber,
          'area': area,
          'city': city,
          "workShopName": workShopName,
          'workadress': workadress,
          'registerDate': FieldValue.serverTimestamp(),
          'email': email,
          'specialization': specialization,
        })
        .then((value) => log("User Added"))
        .catchError((error) => log("Failed to add user: $error"));
  }

  SignInAuth({required String email, required String password}) async {
    try {
      log("owowow");
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(state_success());
    } on FirebaseAuthException catch (e) {
      emit(state_failed(typeFailed: "بيانات الدخول غير صحيحة"));
      log(e.code.toString());
    }
  }
}
