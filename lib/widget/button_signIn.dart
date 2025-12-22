import 'package:car_serves/constant.dart';
import 'package:flutter/material.dart';

class button_signIn extends StatelessWidget {
  button_signIn({super.key, required this.text, required this.onTap});
  final String text;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: BorderRadius.circular(12),
        ),
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.065,
        child: Text(text),
      ),
    );
  }
}
