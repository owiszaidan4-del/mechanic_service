import 'package:car_serves/service/modelDriverInfo.dart';
import 'package:car_serves/service/modelOrders.dart';
import 'package:car_serves/service/modelOrders_.dart';
import 'package:car_serves/views/centerView.dart';
import 'package:car_serves/widget/sheetNewOrderWidget/ArrivalTime_of_sheet_new_order.dart';
import 'package:car_serves/widget/sheetNewOrderWidget/Distance_of_sheet_new_order.dart';
import 'package:car_serves/widget/sheetNewOrderWidget/appBar_of_sheet_new_order.dart';
import 'package:car_serves/widget/sheetNewOrderWidget/firstPart_of_sheet_new_order.dart';
import 'package:car_serves/widget/sheetNewOrderWidget/PickUp_of_sheet_new_order.dart';
import 'package:car_serves/widget/sheetNewOrderWidget/secondPart_of_sheet_new_order.dart';
import 'package:flutter/material.dart';

class sheet_new_order extends StatelessWidget {
  final ModeldriverInfo modeldriverInfo;
  final modelOrders_ modelorders;
  final String idDoc;
  const sheet_new_order({
    super.key,
    required this.modeldriverInfo,
    required this.modelorders,
    required this.idDoc,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.50,
      minChildSize: 0.15,
      maxChildSize: 0.50,
      builder: (context, scrollController) {
        return ListView(
          controller: scrollController,
          children: [
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
                        appBar_of_sheet_new_order(idDoc: idDoc),
                        personalInfo_of_sheet_new_order(
                          modeldriverInfo: modeldriverInfo,
                          userId: modelorders.id,
                        ),

                        Divider(),
                        Issue_of_sheet_new_order(
                          descOfIssue: modelorders.descreption,
                        ),
                        Divider(),
                        Distance_of_sheet_new_order(
                          distanceToDriver: modelorders.distanceToDriver,
                        ),
                        Divider(),
                        ArrivalTime_of_sheet_new_order(
                          arrivaltime: modelorders.arrivaltime,
                        ),
                        Divider(),
                        PickUp_of_sheet_new_order(
                          placemark: modelorders.placemark,
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
