import 'package:flutter/material.dart';

class Performance_Statment extends StatelessWidget {
  const Performance_Statment({super.key, required this.performance});
  final int performance;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            blurStyle: BlurStyle.outer,
            color: Colors.black,
            offset: Offset(0.5, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DefaultTextStyle(
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: AssetImage("asset/condecoration.png"),

                width: 30,
                height: 30,
              ),
              SizedBox(width: 20),
              Column(
                children: [
                  Row(
                    children: [
                      Text("تقييمك الحالي هو "),
                      Text("${performance.round()}%"),
                    ],
                  ),
                  Text(
                    " سيظهر تقييمك عند العملاء ",
                    style: TextStyle(fontSize: 8),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star_border_purple500, color: Colors.brown),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,

                        child: Text(
                          "احرص دائما ان يكون تقييمك اعلى من 50%",
                          style: TextStyle(fontSize: 8),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
