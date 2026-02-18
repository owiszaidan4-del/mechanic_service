import 'dart:developer';

import 'package:car_serves/constant.dart';
import 'package:car_serves/service/ModelNotifcions.dart';
import 'package:car_serves/widget/notifecation/Notification_ListOf_Messages.dart';
import 'package:car_serves/widget/notifecation/Notification_NumAndType_Notification.dart';
import 'package:car_serves/widget/notifecation/notifcionsDesin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Offers extends StatefulWidget {
  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  final Stream<QuerySnapshot> noticStream = FirebaseFirestore.instance
      .collection('notifications')
      .where("type", isEqualTo: "offers")
      .where("targetUserId", isEqualTo: currentUser)
      .orderBy("createdAt", descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: noticStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          log(snapshot.error.toString());
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Column(
            children: [
              Notification_NumAndType_Notification(
                txtType: "جميع العروض",
                numOfMessage: "0 غير مقروء",
              ),
              const Divider(color: Colors.grey, height: 20, thickness: 1),
              Text(
                "لايوجد عروض لغاية الان",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          );
        }

        List<Modelnotifcions> modelNotics = [];
        final docs = snapshot.data!.docs;

        final unreadCount = docs.where((doc) {
          modelNotics.add(Modelnotifcions.fromJson(doc));
          return doc['isRead'] == false;
        }).length;

        return Column(
          children: [
            Notification_NumAndType_Notification(
              txtType: "جميع العروض",
              numOfMessage: "$unreadCount غير مقروء",
            ),
            const Divider(color: Colors.grey, height: 20, thickness: 1),
            Notification_ListOf_Messages(
              itemCount: modelNotics.length,
              itemBuilder: (context, index) {
                return notifcionsDesin(
                  modelNotics: modelNotics[index],
                  idDoc: snapshot.data!.docs[index].id,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
