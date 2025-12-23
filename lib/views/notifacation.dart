import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Notifacation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الرسائل"), centerTitle: true),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: notification_ListOf_TypeMessage(),
                ),
              ),
            ),
            Divider(color: Colors.grey, height: 20, thickness: 3),
            Notification_NumAndType_Notification(),
            Divider(color: Colors.grey, height: 20, thickness: 1),
            Notification_ListOf_Messages(),
          ],
        ),
      ),
    );
  }
}

class Notification_ListOf_Messages extends StatelessWidget {
  const Notification_ListOf_Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListView.builder(
        itemCount: 1,
        padding: EdgeInsets.all(8),
        itemBuilder: (context, index) {
          List l = [];
          if (l.isNotEmpty) {
            return Container();
          } else {
            return Text(
              "لايوجد رسائل لغاية الان",
              style: TextStyle(color: Colors.grey),
            );
          }
        },
      ),
    );
  }
}

class Notification_NumAndType_Notification extends StatelessWidget {
  const Notification_NumAndType_Notification({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("جميع الرسائل"),
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text("0 غير مقروء"),
        ),
      ],
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
