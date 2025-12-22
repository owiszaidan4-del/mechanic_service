import 'package:flutter/material.dart';

class MenueButton extends StatelessWidget {
  MenueButton({super.key, required this.onPressed});
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, right: 8),
      child: Align(
        alignment: Alignment.topRight,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
          child: IconButton(icon: Icon(Icons.menu), onPressed: onPressed),
        ),
      ),
    );
  }
}
