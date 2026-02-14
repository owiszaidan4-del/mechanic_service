import 'package:car_serves/service/modelDriverInfo.dart';
import 'package:car_serves/service/modelOrders_.dart';
import 'package:car_serves/widget/SheetAcceptedOrder/IconGotoGoogleMap_IconManageOrders.dart';
import 'package:flutter/material.dart';

class Sheetarrivedmechanic extends StatelessWidget {
  final ModeldriverInfo modeldriverInfo;
  final modelOrders_ modelorders;
  final String idDoc;
  const Sheetarrivedmechanic({
    required this.modeldriverInfo,
    required this.modelorders,
    required this.idDoc,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      minChildSize: 0.2,
      maxChildSize: 0.60,
      builder: (context, scrollController) {
        return ListView(
          controller: scrollController,
          children: [
            IconGotoGoogleMap_IconManageOrders(
              idDoc: idDoc,
              modeldriverInfo: modeldriverInfo,
              modelorders: modelorders,
            ),
          ],
        );
      },
    );
  }
}
