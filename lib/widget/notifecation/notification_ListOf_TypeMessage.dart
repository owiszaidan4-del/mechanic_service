import 'package:flutter/material.dart';

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
