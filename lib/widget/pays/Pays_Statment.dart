import 'package:car_serves/constant.dart';
import 'package:flutter/material.dart';

class Pays_Statment extends StatelessWidget {
  const Pays_Statment({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.white),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.17,
          decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(colors: colors),
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage("asset/money-bag.png"),

                  width: 30,
                  height: 30,
                ),
                SizedBox(width: 20),
                Column(
                  children: [
                    DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      child: Row(
                        children: [
                          Text("السبت 27 ديسمبر"),
                          Text("-"),
                          Text("اثنين 2 يناير"),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        "44.163 د.أ",
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DefaultTextStyle(
                      style: TextStyle(fontSize: 8, color: Colors.black),
                      child: Expanded(
                        child: Row(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text("المتوسط في الساعة   "),
                                Text(
                                  "${(44.163 / 20).toStringAsFixed(3)} د.أ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text("ساعات العمل"),
                                Text(
                                  "20 س",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
