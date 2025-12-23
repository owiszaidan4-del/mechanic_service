import 'package:flutter/material.dart';

class Notification_ListOf_Messages extends StatelessWidget {
  Notification_ListOf_Messages({super.key, required this.itemBuilder});
  Widget? Function(BuildContext, int) itemBuilder;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListView.builder(
        itemCount: 1,
        padding: EdgeInsets.all(8),
        itemBuilder: itemBuilder,
      ),
    );
  }
}
