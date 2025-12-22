import 'package:flutter/material.dart';

class NameApp extends StatelessWidget {
  const NameApp({super.key, required this.size});
  final double size;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blueAccent, Colors.red],
        ).createShader(bounds);
      },
      child: Text(
        "MechOnWay",
        style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
