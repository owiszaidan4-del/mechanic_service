import 'package:flutter/material.dart';

class widgetIssueInOrder extends StatelessWidget {
  widgetIssueInOrder({
    super.key,
    required this.urlImag,
    required this.text,
    required this.onTap,
  });
  void Function()? onTap;
  final String urlImag;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 8,
            children: [
              Image.asset(
                urlImag,
                width: MediaQuery.of(context).size.width * 0.09,
              ),
              Text(text, style: TextStyle(fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }
}
