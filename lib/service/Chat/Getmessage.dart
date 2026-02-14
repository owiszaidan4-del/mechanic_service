import 'dart:developer';
import 'dart:io';

import 'package:car_serves/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Getmessage {
  Getmessage({required this.userId});
  final String userId;
  sendMessages({required message}) async {
    String chatId = getChatId();
    log(chatId);
    print("userId==========$userId");

    await FirebaseFirestore.instance
        .collection("Chat")
        .doc(chatId)
        .collection("messages")
        .add({
          "message": message,
          "userId": currentUser,
          "cereatedAt": FieldValue.serverTimestamp(),
          "isSeen": false,
        });

    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser)
        .update({
          "messageFrom": FieldValue.arrayUnion([userId]),
        });
    await FirebaseFirestore.instance.collection("users").doc(userId).update({
      "messageFrom": FieldValue.arrayUnion([currentUser]),
    });
  }

  // replayBoot({required String message}){
  //   if(message.contains("اهلا")){}
  // }
  replayToMessage({required message, required repmesaage}) async {
    String chatId = getChatId();
    log(chatId);

    await FirebaseFirestore.instance
        .collection("Chat")
        .doc(chatId)
        .collection("messages")
        .add({
          "message": message,
          "userId": currentUser,
          "cereatedAt": FieldValue.serverTimestamp(),
          "isSeen": false,
          "replaymessage": repmesaage,
        });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser)
        .update({
          "messageFrom": FieldValue.arrayUnion([userId]),
        });
  }

  getSeenState(String doc) async {
    String chatid = getChatId();
    var oo = await FirebaseFirestore.instance
        .collection("Chat")
        .doc(chatid)
        .collection("messages")
        .doc(doc)
        .update({"isSeen": true});
  }

  getChatId() {
    if (currentUser!.compareTo(userId) > 0) {
      return "${currentUser}_$userId";
    } else {
      return "${userId}_$currentUser";
    }
  }

  sendFile(File file, String currentUser) async {
    String? fileId;
    String chatId = getChatId();
    await FirebaseFirestore.instance
        .collection("Chat")
        .doc(chatId)
        .collection("messages")
        .add({
          "message": file.path,
          "userId": currentUser,
          "cereatedAt": FieldValue.serverTimestamp(),
          "isSeen": false,
        })
        .then((value) async {
          fileId = value.id;
        });
    var random = DateTime.now().millisecondsSinceEpoch.toString();
    var fireStoreg = FirebaseStorage.instance.ref(
      "Images_Chat/$chatId/$random",
    );
    await fireStoreg.putFile(file);
    String urlFile = await fireStoreg.getDownloadURL();
    await FirebaseFirestore.instance
        .collection("Chat")
        .doc(chatId)
        .collection("messages")
        .doc(fileId)
        .delete();
    await FirebaseFirestore.instance
        .collection("Chat")
        .doc(chatId)
        .collection("messages")
        .add({
          "message": urlFile,
          "userId": currentUser,
          "cereatedAt": FieldValue.serverTimestamp(),
          "isSeen": false,
        });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser)
        .update({
          "messageFrom": FieldValue.arrayUnion([userId]),
        });
  }
}
