import 'dart:developer';

import 'package:car_serves/cubits/SignIn_Regester/StateManageOrdersState.dart';
import 'package:car_serves/cubits/SignIn_Regester/States_RegesterAuthTransaction.dart';
import 'package:car_serves/cubits/SignIn_Regester/cubitManageOrdersState.dart';
import 'package:car_serves/cubits/SignIn_Regester/cubitRequestOrders.dart';
import 'package:car_serves/views/mapView.dart';
import 'package:car_serves/widget/ItemsOfGradeProfilePage.dart';
import 'package:car_serves/widget/Menue.dart';
import 'package:car_serves/widget/MenueButton.dart';
import 'package:car_serves/widget/SheetAcceptedOrder/Sheet_Accepted_order.dart';
import 'package:car_serves/widget/SheetButtom.dart';
import 'package:car_serves/widget/StateOfWork.dart';
import 'package:car_serves/widget/sheetNewOrderWidget/sheet_new_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class Centerview extends StatefulWidget {
  @override
  State<Centerview> createState() => _CenterviewState();
}

class _CenterviewState extends State<Centerview> {
  bool isOpenMenue = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<Cubitrequestorders>().requestorders();
    checkPermution();
  }

  checkPermution() async {
    PermissionStatus state = await Permission.location.status;

    if (state.isDenied || state.isRestricted) {
      Permission.location.request();
    } else if (state.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ItemsOfGradeProfilePage> items = [
      ItemsOfGradeProfilePage(
        onTap: () {
          Navigator.pushNamed(context, "performance");
        },
        desc: "الاداء الشهري",
        image: AssetImage("asset/good-feedback.png"),
      ),
      ItemsOfGradeProfilePage(
        onTap: () {
          Navigator.pushNamed(context, "notifacation");
        },
        desc: "الاشعارات",
        image: AssetImage("asset/message-notification.png"),
      ),
      ItemsOfGradeProfilePage(
        onTap: () {},
        desc: "تواصل معنا",
        image: AssetImage("asset/live-chat.png"),
      ),

      ItemsOfGradeProfilePage(
        onTap: () {
          Navigator.pushNamed(context, "Paysrecord");
        },
        desc: "المدفوعات",
        image: AssetImage("asset/money.png"),
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Mapview(),
          StateOfWork(),
          MenueButton(
            onPressed: () {
              setState(() {
                isOpenMenue = !isOpenMenue;
              });
              log(isOpenMenue.toString());
            },
          ),
          Menue(
            onHorizontalDragUpdate: (details) {
              if (isOpenMenue && details.delta.dx > 8) {
                setState(() {
                  isOpenMenue = false;
                });
              }
            },
            items: items,
            transform: Matrix4.translationValues(isOpenMenue ? 0 : 300, 0, 0),
          ),
          BlocConsumer<Cubitmanageordersstate, Statemanageordersstate>(
            listener: (context, state) {
              if (state is StateWaiting) {}
            },

            builder: (context, state) {
              if (state is StateWaiting) {
                return sheet_new_order(
                  modeldriverInfo: state.modeldriverInfo,
                  modelorders: state.modelorders,
                  idDoc: state.idDoc,
                );
              } else if (state is StateAcceptOrders) {
                return SheetAcceptedOrder(
                  modeldriverInfo: state.modeldriverInfo,
                  modelorders: state.modelorders,
                );
              }

              return SheetButtom();
            },
          ),
        ],
      ),
    );
  }
}
