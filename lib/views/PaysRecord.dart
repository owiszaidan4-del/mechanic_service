import 'package:car_serves/constant.dart';
import 'package:car_serves/views/performance.dart';
import 'package:car_serves/widget/pays/ListOf_RecordOfPays.dart';
import 'package:car_serves/widget/pays/Pays_Statment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Paysrecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("الدفعات"), centerTitle: true),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          spacing: 20,
          children: [
            Left_Right_Button(text: "هذا الاسبوع"),
            Pays_Statment(),
            Divider(height: 20, thickness: 2, color: Colors.black),
            SizedBox(
              height: height * 0.4,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return ListOf_RecordOfPays(
                    date: "الاثنين،24 ديسمبر",
                    numOfTask: "2",
                    totPrice: "30",
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
