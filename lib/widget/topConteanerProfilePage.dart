import 'package:car_serves/constant.dart';
import 'package:flutter/material.dart';

class topConteanerProfilePage extends StatelessWidget {
  const topConteanerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.solid,
              offset: Offset(1, 1),
              blurRadius: BorderSide.strokeAlignCenter,
            ),
          ],
          gradient: LinearGradient(colors: colors),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 8,

            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "owis Abu Zaidan",
                        style: TextStyle(color: Colors.white),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.blueAccent, size: 20),
                          Text(
                            "4.7  ",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                          Text("2232984", style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              CircleAvatar(radius: 30, child: Icon(Icons.person_2_rounded)),
            ],
          ),
        ),
      ),
    );
  }
}
