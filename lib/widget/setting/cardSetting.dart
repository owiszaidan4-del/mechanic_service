import 'package:flutter/material.dart';

class cardSetting extends StatelessWidget {
  const cardSetting({super.key, required this.titel, required this.children});
  final String titel;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10),
          ],
        ),
        child: Column(
          children: [
            Text(titel),
            Divider(),
            Column(children: children),
          ],
        ),
      ),
    );
  }
}
