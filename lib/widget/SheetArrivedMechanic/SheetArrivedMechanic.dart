import 'package:car_serves/cubits/SignIn_Regester/cubitTakeImage.dart';
import 'package:car_serves/service/modelDriverInfo.dart';
import 'package:car_serves/service/modelOrders_.dart';
import 'package:car_serves/widget/SheetAcceptedOrder/IconGotoGoogleMap_IconManageOrders.dart';
import 'package:car_serves/widget/SheetArrivedMechanic/AppbarOfArrivedMechanic.dart';
import 'package:car_serves/widget/sheetNewOrderWidget/PickUp_of_sheet_new_order.dart';
import 'package:car_serves/widget/sheetNewOrderWidget/firstPart_of_sheet_new_order.dart';
import 'package:car_serves/widget/sheetNewOrderWidget/secondPart_of_sheet_new_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                        AppbarOfArrivedMechanic(idDoc: idDoc),
                        personalInfo_of_sheet_new_order(
                          modeldriverInfo: modeldriverInfo,
                          userId: modelorders.id,
                        ),
                        Divider(),
                        Issue_of_sheet_new_order(
                          descOfIssue: modelorders.descreption,
                        ),
                        Divider(),
                        PickUp_of_sheet_new_order(
                          placemark: modelorders.placemark,
                        ),
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
