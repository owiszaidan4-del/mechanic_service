import 'package:car_serves/constant.dart';
import 'package:flutter/material.dart';

class Performance_itemOfGrid extends StatelessWidget {
  const Performance_itemOfGrid({
    super.key,
    required this.image,
    required this.txt,
  });

  final ImageProvider<Object> image;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {},
        child: DefaultTextStyle(
          style: TextStyle(overflow: TextOverflow.clip),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  color: Colors.black.withOpacity(0.4),
                  blurStyle: BlurStyle.outer,
                ),
              ],
            ),
            child: Row(
              spacing: 20,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: colors),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Image(image: image, color: Colors.white),
                    ),
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "-",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    Text(
                      txt,
                      style: TextStyle(color: Colors.grey, fontSize: 8),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
