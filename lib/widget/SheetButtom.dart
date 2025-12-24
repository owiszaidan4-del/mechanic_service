import 'package:car_serves/constant.dart';
import 'package:car_serves/widget/StateOfWork.dart';
import 'package:flutter/material.dart';

class SheetButtom extends StatefulWidget {
  SheetButtom({super.key});

  @override
  State<SheetButtom> createState() => _SheetButtomState();
}

class _SheetButtomState extends State<SheetButtom> {
  @override
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DraggableScrollableSheet(
      initialChildSize: 0.25,
      minChildSize: 0.15,
      maxChildSize: 0.25,
      builder: (context, scrollController) {
        return ListView(
          controller: scrollController,
          children: [
            DefaultTextStyle(
              style: TextStyle(color: Colors.white),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.245,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: colors),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.black,
                        blurStyle: BlurStyle.outer,
                      ),
                    ],
                  ),
                  child: ValueListenableBuilder(
                    valueListenable: stateOfWOrk,
                    builder: (context, value, child) {
                      if (!value) {
                        return BottomSheet_StateNotWorking(width: width);
                      } else {
                        return bottomSheet_working();
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class bottomSheet_working extends StatelessWidget {
  const bottomSheet_working({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        abbPar(),
        Text(
          "متاح",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("جاري البحث عن طلبات....", style: TextStyle(fontSize: 10)),
            Icon(Icons.search),
          ],
        ),
      ],
    );
  }
}

class BottomSheet_StateNotWorking extends StatelessWidget {
  const BottomSheet_StateNotWorking({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        abbPar(),
        Container(
          width: width * 0.3,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                blurStyle: BlurStyle.outer,
                color: Colors.black,
              ),
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Image.asset(
                "asset/circle.png",
                width: 23,
                height: 24,
                color: Colors.white,
              ),
              Text(
                " ابدأ الان",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Text("غير متاح", style: TextStyle(fontSize: 10)),
        Text(
          "غير حالة العمل الى (يعمل ) لتتمكن من استقبال الطلبات",
          style: TextStyle(fontSize: 8, color: Colors.white),
        ),
      ],
    );
  }
}

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
