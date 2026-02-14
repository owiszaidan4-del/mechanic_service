import 'package:flutter/material.dart';

class ReplayMessage extends StatelessWidget {
  ReplayMessage({
    super.key,
    required this.message,
    required this.closeContenar,
  });
  final String message;
  void Function()? closeContenar;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurStyle: BlurStyle.outer,
            blurRadius: 0.5,
            spreadRadius: 0.5,
          ),
        ],

        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.arrow_circle_right_rounded),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              message,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.black.withOpacity(0.5),
                fontSize: 8,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(icon: Icon(Icons.close), onPressed: closeContenar),
        ],
      ),
    );
  }
}
