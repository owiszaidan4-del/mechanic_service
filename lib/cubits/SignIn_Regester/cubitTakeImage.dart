import 'dart:developer';
import 'dart:io';

import 'package:car_serves/constant.dart';
import 'package:car_serves/cubits/SignIn_Regester/sateTakeImage.dart';
import 'package:car_serves/cubits/SignIn_Regester/stateGetAll_infoUsers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class Cubittakeimage extends Cubit<Satetakeimage> {
  Cubittakeimage() : super(StateInit());

  uploadImageFromDevice({
    required String idDoc,
    required File? pickedCarFile1,
    required File? pickedCarFile2,
  }) async {
    try {
      if (pickedCarFile1 != null && pickedCarFile2 != null) {
        final lastPath1 = pickedCarFile1.path.split("/").last;
        final lastPath2 = pickedCarFile1.path.split("/").last;

        final ref1 = FirebaseStorage.instance.ref(
          "carPhoto/car/$currentUser/$lastPath1",
        );
        final ref2 = FirebaseStorage.instance.ref(
          "carPhoto/issue/$currentUser/$lastPath1",
        );

        emit(StateUploadLoading());
        await ref1.putFile(pickedCarFile1);
        await ref2.putFile(pickedCarFile2);
        final carDriverPhotoUrl = await ref1.getDownloadURL();
        final carDriverIssuePhotoUrl = await ref2.getDownloadURL();
        await FirebaseFirestore.instance.collection("orders").doc(idDoc).set({
          "carDriverPhoto": carDriverPhotoUrl,
          "carDriverIssuePhoto": carDriverIssuePhotoUrl,
          "stateOfRequest": "done",
        }, SetOptions(merge: true));
        await FirebaseFirestore.instance
            .collection("mechanicOnline")
            .doc(currentUser)
            .update({"available": true});
        log("done Upload IMages");
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
