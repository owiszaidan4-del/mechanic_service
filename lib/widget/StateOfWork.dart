import 'dart:developer';

import 'package:car_serves/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

ValueNotifier<bool> stateOfWOrk = ValueNotifier(false);

class StateOfWork extends StatefulWidget {
  const StateOfWork({super.key});

  @override
  State<StateOfWork> createState() => _StateOfWorkState();
}

class _StateOfWorkState extends State<StateOfWork> {
  bool state = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!)
          .snapshots(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasError) {
          return Text('Something went wrong');
        }

        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        final stateOfWork = asyncSnapshot.data!.data()!["stateOfWork"];

        return Padding(
          padding: EdgeInsetsGeometry.only(top: 30),
          child: Align(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onTap: () async {
                await FirebaseFirestore.instance
                    .collection("users")
                    .doc(currentUser!)
                    .update({"stateOfWork": !stateOfWork});
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,

                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      blurStyle: BlurStyle.outer,
                      color: Colors.black,
                    ),
                  ],
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(30),
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "حالة العمل",
                            style: TextStyle(color: Colors.grey, fontSize: 6),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (stateOfWork)
                                Text(
                                  "يعمل",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              if (stateOfWork == false)
                                Text(
                                  "لا يعمل",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: stateOfWork
                                ? Colors.lightGreen
                                : Colors.blueGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
