import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Notifacation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الرسائل"), centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 30,
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: 10,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: notification_ListOf_TypeMessage(),
                ),
              ),
            ),
          ),
          Divider(color: Colors.grey, height: 10, thickness: 3),
        ],
      ),
    );
  }
}

class notification_ListOf_TypeMessage extends StatelessWidget {
  const notification_ListOf_TypeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(onTap: () {}, child: Text("جميع الرسائل(0)")),
        GestureDetector(onTap: () {}, child: Text("تنبيهات(0)")),
        GestureDetector(onTap: () {}, child: Text("العروض(0)")),
      ],
    );
  }
}
