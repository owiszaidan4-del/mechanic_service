import 'package:car_serves/widget/notifecation/Notification_ListOf_Messages.dart';
import 'package:car_serves/widget/notifecation/Notification_NumAndType_Notification.dart';
import 'package:flutter/material.dart';

class Offers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Notification_NumAndType_Notification(
          txtType: "جميع العروض",
          numOfMessage: "0 غير مقروء",
        ),
        const Divider(color: Colors.grey, height: 20, thickness: 1),
        Notification_ListOf_Messages(
          itemBuilder: (context, index) {
            List l = [];
            if (l.isNotEmpty) {
              return Container();
            } else {
              return Text(
                "لايوجد عروض لغاية الان",
                style: TextStyle(color: Colors.grey),
              );
            }
          },
        ),
      ],
    );
    ;
  }
}
