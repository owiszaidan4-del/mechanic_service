import 'package:car_serves/service/modelDriverInfo.dart';
import 'package:car_serves/views/centerView.dart';
import 'package:car_serves/widget/sheetNewOrderWidget/appBar_of_sheet_new_order.dart';
import 'package:car_serves/widget/sheetNewOrderWidget/firstPart_of_sheet_new_order.dart';
import 'package:flutter/material.dart';

class sheet_new_order extends StatelessWidget {
  final ModeldriverInfo modeldriverInfo;
  const sheet_new_order({super.key, required this.modeldriverInfo});

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    appBar_of_sheet_new_order(),
                    firstPart_of_sheet_new_order(
                      carModel: modeldriverInfo.careModel,
                      name: modeldriverInfo.full_name,
                      urlImage: modeldriverInfo.urlImage,
                    ),

                    Divider(),

                    //end
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
