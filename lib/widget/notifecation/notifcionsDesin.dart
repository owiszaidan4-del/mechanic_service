import 'package:car_serves/constant.dart';
import 'package:car_serves/service/ModelNotifcions.dart';
import 'package:car_serves/widget/notifecation/noticView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class notifcionsDesin extends StatelessWidget {
  const notifcionsDesin({
    super.key,
    required this.modelNotics,
    required this.idDoc,
  });

  final Modelnotifcions modelNotics;
  final String idDoc;
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = modelNotics.createdAt.toDate();
    final createdAt = DateFormat('yyyy-mm-dd').format(dateTime).toString();
    return GestureDetector(
      onTap: () async {
        //go to the notic
        //
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoticView(modelnotifcions: modelNotics),
          ),
        );
        //
        await FirebaseFirestore.instance
            .collection("notifications")
            .doc(idDoc)
            .update({"isRead": true});
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        height: MediaQuery.of(context).size.height * 0.13,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: modelNotics.isRead
                    ? null
                    : LinearGradient(colors: colors),
                borderRadius: BorderRadius.circular(8),
              ),
              width: 3,
            ),
            Column(
              children: [
                titleNotic(modelNotics: modelNotics, createdAt: createdAt),
                bodyNotic(modelNotics: modelNotics),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class bodyNotic extends StatelessWidget {
  const bodyNotic({super.key, required this.modelNotics});

  final Modelnotifcions modelNotics;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,

      child: Text(
        modelNotics.body,
        maxLines: 2,
        style: TextStyle(
          fontSize: 10,
          color: Colors.blueGrey.withOpacity(0.6),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class titleNotic extends StatelessWidget {
  const titleNotic({
    super.key,
    required this.modelNotics,
    required this.createdAt,
  });

  final Modelnotifcions modelNotics;
  final String createdAt;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(
              modelNotics.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            ),
          ),
          Text(
            createdAt,
            style: TextStyle(
              fontSize: 10,
              color: Colors.black.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }
}
