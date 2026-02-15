import 'package:car_serves/constant.dart';
import 'package:car_serves/service/ModelNotifcions.dart';
import 'package:car_serves/widget/notifecation/Notification_ListOf_Messages.dart';
import 'package:car_serves/widget/notifecation/Notification_NumAndType_Notification.dart';
import 'package:car_serves/widget/notifecation/notifcionsDesin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Allnotifecation extends StatefulWidget {
  @override
  State<Allnotifecation> createState() => _AllnotifecationState();
}

class _AllnotifecationState extends State<Allnotifecation> {
  final Stream<QuerySnapshot> noticStream = FirebaseFirestore.instance
      .collection('notifications')
      .orderBy("createdAt")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Notification_NumAndType_Notification(
          txtType: "جميع الرسائل",
          numOfMessage: "0 غير مقروء",
        ),
        const Divider(color: Colors.grey, height: 20, thickness: 1),
        StreamBuilder(
          stream: noticStream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            if (!snapshot.hasData) {
              return Text(
                "لايوجد رسائل لغاية الان",
                style: TextStyle(color: Colors.grey),
              );
            }
            final notics = snapshot.data!.docs;
            List<Modelnotifcions> modelNotics = [];
            for (var element in notics) {
              modelNotics.add(Modelnotifcions.fromJson(element));
            }
            return Notification_ListOf_Messages(
              itemCount: modelNotics.length,
              itemBuilder: (context, index) {
                if (modelNotics.isNotEmpty) {
                  return notifcionsDesin(modelNotics: modelNotics[index]);
                } else {
                  return Text(
                    "لايوجد رسائل لغاية الان",
                    style: TextStyle(color: Colors.grey),
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}
