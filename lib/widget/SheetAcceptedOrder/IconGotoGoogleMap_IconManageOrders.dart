import 'dart:developer';

import 'package:car_serves/widget/SheetAcceptedOrder/IconGoToGoogleMap.dart';
import 'package:car_serves/widget/SheetAcceptedOrder/Sheet_Accepted_order.dart';
import 'package:car_serves/widget/bottomSheet/abbPar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IconGotoGoogleMap_IconManageOrders extends StatelessWidget {
  const IconGotoGoogleMap_IconManageOrders({super.key, required this.widget});

  final SheetAcceptedOrder widget;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconGoToGoogleMap(
              urlImage: "asset/carLocation.png",
              widget: widget,
              onTap: () async {
                await goToGoogleMap();
              },
            ),
            IconGoToGoogleMap(
              urlImage: "asset/error.png",
              widget: widget,
              onTap: () async {
                await orderIssueDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> orderIssueDialog(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              abbPar(),
              Center(child: Text("حدثت مشكلة؟")),
              Divider(color: Colors.black, thickness: 2),
              widgetIssueInOrder(
                onTap: () {},
                text: "العميل لايرد",
                urlImag: "asset/phone.png",
              ),
              Divider(),

              widgetIssueInOrder(
                onTap: () {},
                text: "لا استطيع الوصول للموقع",
                urlImag: "asset/location.png",
              ),
              Divider(),
              widgetIssueInOrder(
                onTap: () {},
                text: "سوف اتأخر بالطريق",
                urlImag: "asset/chronometer.png",
              ),
              Divider(color: Colors.grey.withOpacity(0.2), thickness: 17),
              widgetIssueInOrder(
                onTap: () {},
                text: "إلغاء الطلب",
                urlImag: "asset/cancel.png",
              ),
              Divider(),
              widgetIssueInOrder(
                onTap: () {},
                text: "التحدث مع الدعم",
                urlImag: "asset/live-chat.png",
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> goToGoogleMap() async {
    final Uri uri = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=${widget.modelorders.lat},${widget.modelorders.lng}",
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      log("cant LaunchUrl");
    }
  }
}

class widgetIssueInOrder extends StatelessWidget {
  widgetIssueInOrder({
    super.key,
    required this.urlImag,
    required this.text,
    required this.onTap,
  });
  void Function()? onTap;
  final String urlImag;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 8,
            children: [
              Image.asset(
                urlImag,
                width: MediaQuery.of(context).size.width * 0.09,
              ),
              Text(text, style: TextStyle(fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }
}
