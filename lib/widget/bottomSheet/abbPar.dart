import 'package:flutter/material.dart';

class abbPar extends StatelessWidget {
  const abbPar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      height: 4,
      width: MediaQuery.of(context).size.width * 0.15,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
