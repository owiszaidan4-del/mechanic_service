import 'dart:developer';
import 'dart:io';

import 'package:car_serves/constant.dart';
import 'package:car_serves/cubits/SignIn_Regester/cubitGetAll__infoUsers.dart';
import 'package:car_serves/cubits/SignIn_Regester/stateGetAll_infoUsers.dart';
import 'package:car_serves/service/Getimagefromedevice.dart';
import 'package:car_serves/views/Settings/circleImage.dart';
import 'package:car_serves/views/Settings/textAbleToCopy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';

class Editprofileimage extends StatefulWidget {
  @override
  State<Editprofileimage> createState() => _EditprofileimageState();
}

class _EditprofileimageState extends State<Editprofileimage> {
  String? newimagePath;
  Widget? circularProgress = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ملفي"), centerTitle: true),
      body: BlocBuilder<cubitGetAll__infoUsers, StategetallInfousers>(
        builder: (context, state) {
          if (state is StateSucsess) {
            return Column(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                circleImage(
                  urlImage: state.allInfoUsers.urlImage,
                  newimagePath: newimagePath,
                  circularProgress: circularProgress,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _updateProfileImage();
                  },
                  child: Text("تعديل الصورة"),
                ),
                textAbleToCopy(text: state.allInfoUsers.fullName),
                textAbleToCopy(text: state.allInfoUsers.userId),
              ],
            );
          } else if (state is StateLoad || state is InetialState) {
            Center(child: CircularProgressIndicator());
          } else if (state is StateFaield) {
            Center(child: Text("faild to load data...."));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Future<void> _updateProfileImage() async {
    try {
      final pathImage = await Getimagefromedevice(
        cropStyle: CropStyle.circle,
        lockAspectRatio: true,
      ).ImageFromDevice();

      if (pathImage == null) return;

      setState(() {
        newimagePath = pathImage;
        circularProgress = const Center(child: CircularProgressIndicator());
      });

      final refStorage = FirebaseStorage.instance.ref(
        "imageProfile/$currentUser",
      );

      final fileImage = File(pathImage);

      await refStorage.putFile(fileImage);

      final url = await refStorage.getDownloadURL();

      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser)
          .update({"urlImage": url});

      log("done edit image");

      setState(() {
        circularProgress = const Center(
          child: Icon(Icons.done_all, color: Colors.green),
        );
      });

      context.read<cubitGetAll__infoUsers>().getAllinfoUsers();
    } catch (e) {
      log("error edit image: ${e.toString()}");
    }
  }
}
