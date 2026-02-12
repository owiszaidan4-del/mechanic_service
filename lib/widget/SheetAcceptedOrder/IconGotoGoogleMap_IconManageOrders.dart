import 'dart:developer';

import 'package:car_serves/widget/SheetAcceptedOrder/IconGoToGoogleMap.dart';
import 'package:car_serves/widget/SheetAcceptedOrder/Sheet_Accepted_order.dart';
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
        return Container(color: Colors.white);
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
