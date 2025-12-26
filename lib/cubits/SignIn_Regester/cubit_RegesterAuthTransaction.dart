import 'package:bloc/bloc.dart';
import 'package:car_serves/constant.dart';
import 'package:car_serves/cubits/SignIn_Regester/States_RegesterAuthTransaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CubitRegesterauthtransaction
    extends Cubit<StatesRegesterauthtransaction> {
  CubitRegesterauthtransaction(
    super.initialState, {
    this.email,
    this.fullName,
    this.confirmPassword,
    this.password,
    this.phoneNumber,
    this.area,
    this.city,
    this.workShopName,
    this.workadress,
  });
  String? email;
  String? password;
  String? phoneNumber;
  String? confirmPassword;
  String? fullName;
  String? workShopName;

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
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      emit(state_success());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(state_failed(typeFailed: 'The password provided is too weak.'));
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        emit(
          state_failed(
            typeFailed: 'The account already exists for that email.',
          ),
        );
        print('The account already exists for that email.');
        return;
      }
    } catch (e) {
      emit(state_failed(typeFailed: e.toString()));
      print(e);
      return;
    }
    //fireStore
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Call the user's CollectionReference to add a new user
    return users
        .doc("rouls")
        .collection(currentUser)
        .add({
          'full_name': fullName,
          'phoneNumber': phoneNumber,
          'area': area,
          'city': city,
          "workShopName": workShopName,
          'workadress': workadress,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
