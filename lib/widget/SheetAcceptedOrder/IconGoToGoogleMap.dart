import 'package:car_serves/widget/SheetAcceptedOrder/Sheet_Accepted_order.dart';
import 'package:flutter/material.dart';

class IconGoToGoogleMap extends StatelessWidget {
  IconGoToGoogleMap({
    super.key,
    required this.widget,
    required this.onTap,
    required this.urlImage,
  });
  void Function()? onTap;
  final String urlImage;
  final SheetAcceptedOrder widget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          // boxShadow: [BoxShadow(blurRadius: 20, blurStyle: BlurStyle.inner)],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(
          urlImage,
          width: MediaQuery.of(context).size.width * 0.13,
          height: MediaQuery.of(context).size.width * 0.13,
          color: Colors.black,
        ),
      ),
    );
  }
}
