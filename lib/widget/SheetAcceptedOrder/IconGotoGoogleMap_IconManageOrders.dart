import 'dart:developer';

import 'package:car_serves/service/modelDriverInfo.dart';
import 'package:car_serves/service/modelOrders_.dart';
import 'package:car_serves/views/ChatView.dart';
import 'package:car_serves/widget/SheetAcceptedOrder/IconGoToGoogleMap.dart';
import 'package:car_serves/widget/SheetAcceptedOrder/Sheet_Accepted_order.dart';
import 'package:car_serves/widget/SheetAcceptedOrder/_expectedTimeLayOutState.dart';
import 'package:car_serves/widget/SheetAcceptedOrder/widgetIssueInOrder.dart';
import 'package:car_serves/widget/bottomSheet/abbPar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IconGotoGoogleMap_IconManageOrders extends StatelessWidget {
  const IconGotoGoogleMap_IconManageOrders({
    super.key,
    required this.idDoc,
    required this.modeldriverInfo,
    required this.modelorders,
  });
  final String idDoc;

  final ModeldriverInfo modeldriverInfo;
  final modelOrders_ modelorders;
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

              onTap: () async {
                await goToGoogleMap();
              },
            ),
            IconGoToGoogleMap(
              urlImage: "asset/error.png",

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
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Chatview(
                        initText: "العميل لا يرد على الهاتف",
                        chatWithAdmin: true,
                        userId: "R2tid7z25Po1HCP7aHA2",
                        modelDrider: modeldriverInfo,
                      ),
                    ),
                  );
                },
                text: "العميل لايرد",
                urlImag: "asset/phone.png",
              ),
              Divider(),

              widgetIssueInOrder(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Chatview(
                        initText: "لا استطيع الوصول للموقع",
                        chatWithAdmin: true,
                        userId: "R2tid7z25Po1HCP7aHA2",
                        modelDrider: modeldriverInfo,
                      ),
                    ),
                  );
                },
                text: "لا استطيع الوصول للموقع",
                urlImag: "asset/location.png",
              ),
              Divider(),
              widgetIssueInOrder(
                onTap: () {
                  showDialog(
                    context: context,

                    builder: (context) {
                      return expectedTimeLayOut(
                        arrivalTime: modelorders.arrivaltime,
                        idDoc: idDoc,
                      );
                    },
                  );
                },
                text: "سوف اتأخر بالطريق",
                urlImag: "asset/chronometer.png",
              ),
              Divider(color: Colors.grey.withOpacity(0.2), thickness: 17),
              widgetIssueInOrder(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Chatview(
                        initText: " ارغب في الغاء الطلب",
                        chatWithAdmin: true,
                        userId: "R2tid7z25Po1HCP7aHA2",
                        modelDrider: modeldriverInfo,
                      ),
                    ),
                  );
                },
                text: "إلغاء الطلب",
                urlImag: "asset/cancel.png",
              ),
              Divider(),
              widgetIssueInOrder(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Chatview(
                        initText: "التحدث مع الدعم",
                        chatWithAdmin: true,
                        userId: "R2tid7z25Po1HCP7aHA2",
                        modelDrider: modeldriverInfo,
                      ),
                    ),
                  );
                },
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
      "https://www.google.com/maps/search/?api=1&query=${modelorders.lat},${modelorders.lng}",
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      log("cant LaunchUrl");
    }
  }
}
