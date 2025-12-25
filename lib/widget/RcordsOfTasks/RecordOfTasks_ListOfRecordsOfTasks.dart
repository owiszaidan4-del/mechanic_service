import 'package:car_serves/constant.dart';
import 'package:car_serves/widget/RcordsOfTasks/personInfo_card.dart';
import 'package:flutter/material.dart';

class RecordOfTasks_ListOfRecordsOfTasks extends StatelessWidget {
  const RecordOfTasks_ListOfRecordsOfTasks({
    super.key,
    required this.width,
    required this.totPrice,
  });

  final double width;
  final String totPrice;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                backgroundColor: Colors.black.withOpacity(0.0),
                content: personInfo_card(
                  name: 'أويس ابو زيدان',
                  phoneNumber: '0791234567',
                  proplemVechel: 'عطل بالمحرك',
                ),
              ),
            );
          },
        );
      },
      child: Container(
        width: width * 0.8,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              blurStyle: BlurStyle.outer,
              color: Colors.black,
            ),
          ],
          gradient: LinearGradient(
            colors: colors,
            // [
            //   const Color.fromARGB(255, 36, 35, 35),
            //   const Color.fromARGB(255, 245, 225, 225),
            // ],
          ),
          color: Colors.white.withOpacity(0.7),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "kia-optema",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "14:43-15:22",
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    ),
                    Text(
                      "42-3213",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("$totPrice د.أ "),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Icon(Icons.arrow_back_ios),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
