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
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            margin: EdgeInsets.all(8),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurStyle: BlurStyle.outer,
                  color: Colors.black,
                  blurRadius: 30,
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("asset/menu.png"),
            ),
          ),
        ),
      ),
    );
  }
}
// IconButton(icon: Icon(Icons.menu), onPressed: onPressed)