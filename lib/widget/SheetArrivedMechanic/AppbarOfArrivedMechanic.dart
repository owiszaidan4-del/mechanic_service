import 'dart:developer';
import 'dart:io';

import 'package:car_serves/constant.dart';
import 'package:car_serves/cubits/SignIn_Regester/cubitTakeImage.dart';
import 'package:car_serves/widget/SheetArrivedMechanic/widgetTake_Photo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AppbarOfArrivedMechanic extends StatelessWidget {
  const AppbarOfArrivedMechanic({super.key, required this.idDoc});
  final String idDoc;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (dialogcontext) {
            return BlocProvider.value(
              value: context.read<Cubittakeimage>(),
              child: daownloadImagesEndedOfTask(idDoc: idDoc),
            );
          },
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        margin: EdgeInsets.only(bottom: 8),
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blueGrey,
        ),
        child: Text("انهاء المهمة", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class daownloadImagesEndedOfTask extends StatefulWidget {
  const daownloadImagesEndedOfTask({super.key, required this.idDoc});
  final String idDoc;
  @override
  State<daownloadImagesEndedOfTask> createState() =>
      _daownloadImagesEndedOfTaskState();
}

class _daownloadImagesEndedOfTaskState
    extends State<daownloadImagesEndedOfTask> {
  File? imageFile1;
  File? imageFile2;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Row(
                spacing: 50,
                children: [
                  Icon(Icons.cancel_outlined),
                  Text("تحميل صور انهاء المهمة"),
                ],
              ),
              Text("يرجى تحميل الصور التالية لاتمام انهاء المهمة"),

              widgetTake_Photo(
                onPressed: () {
                  setState(() {
                    imageFile1 = null;
                  });
                },
                isDawonload: imageFile1 != null ? true : false,
                text: "صورة كاملة للسيارة",
                onTap: () async {
                  final pickedFile = await ImagePicker().pickImage(
                    source: ImageSource.camera,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      final File file = File(pickedFile.path);
                      imageFile1 = file;
                    });
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: widgetTake_Photo(
                  onPressed: () {
                    setState(() {
                      imageFile2 = null;
                    });
                  },
                  isDawonload: imageFile2 != null ? true : false,
                  text: "صورة لمكان العطل",
                  onTap: () async {
                    final pickedFile = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                    );
                    if (pickedFile != null) {
                      setState(() {
                        final File file = File(pickedFile.path);
                        imageFile2 = file;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "ملاحظة يجب التقاط الصور في مكان اصلاح السيارة",
                  style: TextStyle(overflow: TextOverflow.clip),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (imageFile1 != null && imageFile2 != null) {
                    BlocProvider.of<Cubittakeimage>(
                      context,
                    ).uploadImageFromDevice(
                      idDoc: widget.idDoc,
                      pickedCarFile1: imageFile1,
                      pickedCarFile2: imageFile2,
                    );
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: imageFile1 != null && imageFile2 != null
                        ? Colors.blueGrey
                        : Colors.blueGrey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,

                  child: Center(
                    child: Text(
                      "تاكيد انهاء المهمة",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
