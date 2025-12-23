import 'package:flutter/material.dart';

class Notification_divider_Animation extends StatelessWidget {
  const Notification_divider_Animation({
    super.key,
    required double currentIndent,
    required this.width,
  }) : _currentIndent = currentIndent;

  final double _currentIndent;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.grey,
      height: 20,
      thickness: 3,
      indent: _currentIndent,
      endIndent: width - _currentIndent - 90,
    );
  }
}
