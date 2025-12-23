import 'package:flutter/material.dart';

class Notification_NumAndType_Notification extends StatelessWidget {
  const Notification_NumAndType_Notification({
    super.key,
    required this.txtType,
    required this.numOfMessage,
  });
  final String txtType;
  final String numOfMessage;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(txtType),
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(numOfMessage),
        ),
      ],
    );
  }
}
