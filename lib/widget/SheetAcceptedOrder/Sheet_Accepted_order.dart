import 'dart:developer';

import 'package:car_serves/constant.dart';
import 'package:car_serves/service/modelDriverInfo.dart';
import 'package:car_serves/service/modelOrders_.dart';
import 'package:car_serves/widget/SheetAcceptedOrder/IconGotoGoogleMap_IconManageOrders.dart';
import 'package:car_serves/widget/SheetAcceptedOrder/appBar_of_sheet_Accepted_order.dart';
import 'package:car_serves/widget/sheetNewOrderWidget/ArrivalTime_of_sheet_new_order.dart';
import 'package:car_serves/widget/sheetNewOrderWidget/Distance_of_sheet_new_order.dart';
import 'package:car_serves/widget/sheetNewOrderWidget/PickUp_of_sheet_new_order.dart';
import 'package:car_serves/widget/sheetNewOrderWidget/appBar_of_sheet_new_order.dart';
import 'package:car_serves/widget/sheetNewOrderWidget/firstPart_of_sheet_new_order.dart';
import 'package:car_serves/widget/sheetNewOrderWidget/secondPart_of_sheet_new_order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SheetAcceptedOrder extends StatefulWidget {
  final ModeldriverInfo modeldriverInfo;
  final modelOrders_ modelorders;

  const SheetAcceptedOrder({
    required this.modeldriverInfo,
    required this.modelorders,
  });

  @override
  State<SheetAcceptedOrder> createState() => _SheetAcceptedOrderState();
}

class _SheetAcceptedOrderState extends State<SheetAcceptedOrder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            IconGotoGoogleMap_IconManageOrders(widget: widget),

            Container(
              height: MediaQuery.of(context).size.height * 0.50,
              decoration: BoxDecoration(
                color: Colors.white,
                //  gradient: LinearGradient(colors: colors),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: Colors.black,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: DefaultTextStyle(
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppbarOfSheetAcceptedOrder(),
                        personalInfo_of_sheet_new_order(
                          carModel: widget.modeldriverInfo.careModel,
                          name: widget.modeldriverInfo.full_name,
                          urlImage: widget.modeldriverInfo.urlImage,
                        ),

                        Divider(),
                        Issue_of_sheet_new_order(
                          descOfIssue: widget.modelorders.descreption,
                        ),
                        Divider(),
                        Distance_of_sheet_new_order(
                          distanceToDriver: widget.modelorders.distanceToDriver,
                        ),
                        Divider(),
                        ArrivalTime_of_sheet_new_order(
                          arrivaltime: widget.modelorders.arrivaltime,
                        ),
                        Divider(),
                        PickUp_of_sheet_new_order(
                          placemark: widget.modelorders.placemark,
                        ),
                        //end
                      ],
                    ),
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
