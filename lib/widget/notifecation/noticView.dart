import 'package:car_serves/service/ModelNotifcions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoticView extends StatelessWidget {
  final Modelnotifcions modelnotifcions;
  const NoticView({required this.modelnotifcions});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("رسالة"), centerTitle: true),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                modelnotifcions.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  modelnotifcions.body,
                  style: TextStyle(fontSize: 10),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection("notifications")
                      .add({
                        "body": "اهلا اهلا اهلا",
                        "isRead": false,
                        "createdAt": FieldValue.serverTimestamp(),
                        "targetUserId": "EuHEIiPU2TRGs2W9SAePYXAzL3A2",
                        "title": "اهلا اويس ",
                        "type": "worring",
                      });
                },
                child: Text("test"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
