import 'package:flutter/material.dart';

class messageEndedTask extends StatelessWidget {
  const messageEndedTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          width: MediaQuery.of(context).size.width * 0.8,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("انتهت المهمة بنجاح", style: TextStyle(color: Colors.white)),
              Icon(
                Icons.done_all,
                color: const Color.fromARGB(255, 73, 100, 74),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
