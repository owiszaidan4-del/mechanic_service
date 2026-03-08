import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class textAbleToCopy extends StatelessWidget {
  const textAbleToCopy({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TextStyle(fontSize: 8)),
          IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: text));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Center(child: Text("تم نسخ النص"))),
              );
            },
            icon: Icon(Icons.copy),
          ),
        ],
      ),
    );
  }
}
