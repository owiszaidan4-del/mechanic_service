import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class expectedTimeLayOut extends StatefulWidget {
  const expectedTimeLayOut({
    super.key,
    required this.arrivalTime,
    required this.idDoc,
  });
  final double arrivalTime;
  final String idDoc;
  @override
  State<expectedTimeLayOut> createState() => _expectedTimeLayOutState();
}

class _expectedTimeLayOutState extends State<expectedTimeLayOut> {
  int timalayout = 0;
  GlobalKey globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),

        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: Center(
                child: Column(
                  children: [
                    Image.asset(
                      "asset/chronometer.png",
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Text(
                      "ادخل مدة التأخير المتوقع",
                      style: TextStyle(fontSize: 10),
                    ),
                    Material(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.08,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.deepPurple.withOpacity(0.2),
                        ),
                        child: DropdownButtonFormField<int>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          hint: Text(
                            "المدة الزمنية المتوقعة",
                            style: TextStyle(fontSize: 8),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 10,
                              child: Text(
                                "من 1 الى 10 دقائق",
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 20,
                              child: Text(
                                "من 11 الى 20 دقيقة",
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              timalayout = value ?? 0;
                            });
                          },
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (timalayout != 0) {
                              double newArivalTime =
                                  (widget.arrivalTime + timalayout);
                              log(timalayout.toString());
                              await FirebaseFirestore.instance
                                  .collection("orders")
                                  .doc(widget.idDoc)
                                  .update({"arrivaltime": newArivalTime});
                            }
                          },
                          child: Text("ارسال"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("الغاء"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
