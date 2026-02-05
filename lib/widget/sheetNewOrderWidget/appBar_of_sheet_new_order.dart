import 'package:car_serves/constant.dart';
import 'package:flutter/material.dart';

class appBar_of_sheet_new_order extends StatelessWidget {
  const appBar_of_sheet_new_order({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: colors),
      ),
      child: Text("طلب جديد قادم", style: TextStyle(color: Colors.white)),
    );
  }
}
