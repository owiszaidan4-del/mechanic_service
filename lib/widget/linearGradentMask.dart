import 'package:flutter/material.dart';

class linearGradentMask extends StatelessWidget {
  const linearGradentMask({super.key, required this.widget});
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (b) {
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blueAccent, Colors.redAccent],
        ).createShader(b);
      },
      child: widget,
    );
  }
}
