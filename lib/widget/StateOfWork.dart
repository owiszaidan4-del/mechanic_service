import 'package:flutter/material.dart';

class StateOfWork extends StatefulWidget {
  const StateOfWork({super.key});

  @override
  State<StateOfWork> createState() => _StateOfWorkState();
}

class _StateOfWorkState extends State<StateOfWork> {
  bool state = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(top: 30),
      child: Align(
        alignment: Alignment.topCenter,
        child: GestureDetector(
          onTap: () {
            setState(() {
              state = !state;
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              color: state ? Colors.green : Colors.redAccent,

              borderRadius: BorderRadius.circular(20),
            ),
            child: state
                ? Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.done_all, color: Colors.white, size: 25),
                        Text("متوفر", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  )
                : Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "غير متوفر",
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.cancel_outlined,
                          color: Colors.white,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
