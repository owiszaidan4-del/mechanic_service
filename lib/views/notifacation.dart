import 'package:car_serves/views/notification/AllNotifecation.dart';
import 'package:car_serves/views/notification/Offers.dart';
import 'package:car_serves/views/notification/worring.dart';
import 'package:car_serves/widget/notifecation/Notification_divider_Animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Notifacation extends StatefulWidget {
  @override
  State<Notifacation> createState() => _NotifacationState();
}

class _NotifacationState extends State<Notifacation> {
  double _currentIndent = 10;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _menuItem("الكل", 10, 0),
                    _menuItem("تنبيهات", width * 0.35, 1),
                    _menuItem("عروض", width * 0.7, 2),
                  ],
                ),
              ),
            ),

            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: Notification_divider_Animation(
                currentIndent: _currentIndent,
                width: width,
              ),
            ),
            IndexedStack(
              index: index,
              children: [Allnotifecation(), Worring(), Offers()],
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(String title, double indentValue, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          this.index = index;
          _currentIndent = indentValue;
        });
      },
      child: Text(title),
    );
  }
}
