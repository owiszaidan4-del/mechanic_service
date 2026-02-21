import 'package:car_serves/cubits/SignIn_Regester/cubitManageOrdersState.dart';
import 'package:car_serves/cubits/SignIn_Regester/cubitRequestOrders.dart';
import 'package:car_serves/cubits/SignIn_Regester/StateManageOrdersState.dart';
import 'package:car_serves/service/modelOrders_.dart';
import 'package:car_serves/views/ChatView.dart';
import 'package:car_serves/views/mapView.dart';
import 'package:car_serves/widget/ItemsOfGradeProfilePage.dart';
import 'package:car_serves/widget/Menue.dart';
import 'package:car_serves/widget/MenueButton.dart';
import 'package:car_serves/widget/SheetAcceptedOrder/Sheet_Accepted_order.dart';
import 'package:car_serves/widget/SheetAcceptedOrder/messageEndedTask.dart';
import 'package:car_serves/widget/SheetArrivedMechanic/SheetArrivedMechanic.dart';
import 'package:car_serves/widget/SheetButtom.dart';
import 'package:car_serves/widget/StateOfWork.dart';
import 'package:car_serves/widget/sheetNewOrderWidget/sheet_new_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class Centerview extends StatefulWidget {
  const Centerview({super.key});

  @override
  State<Centerview> createState() => _CenterviewState();
}

class _CenterviewState extends State<Centerview> {
  bool _isOpenMenu = false;

  @override
  void initState() {
    super.initState();
    context.read<Cubitrequestorders>().requestorders();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    final state = await Permission.location.status;

    if (state.isDenied || state.isRestricted) {
      await Permission.location.request();
    } else if (state.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = _buildMenuItems(context);

    return Scaffold(
      body: Stack(
        children: [
          Mapview(),
          const StateOfWork(),
          _buildMenuButton(),
          _buildMenu(items),
          _buildBottomSheets(),
        ],
      ),
    );
  }

  // =========================
  // 🔹 Menu Items
  // =========================

  List<ItemsOfGradeProfilePage> _buildMenuItems(BuildContext context) {
    return [
      ItemsOfGradeProfilePage(
        onTap: () => Navigator.pushNamed(context, "performance"),
        desc: "الاداء الشهري",
        image: const AssetImage("asset/good-feedback.png"),
      ),
      ItemsOfGradeProfilePage(
        onTap: () => Navigator.pushNamed(context, "notifacation"),
        desc: "الاشعارات",
        image: const AssetImage("asset/message-notification.png"),
      ),
      ItemsOfGradeProfilePage(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Chatview(
              initText: "التحدث مع الدعم",
              chatWithAdmin: true,
              userId: "R2tid7z25Po1HCP7aHA2",
              modelDrider: null,
            ),
          ),
        ),
        desc: "تواصل معنا",
        image: const AssetImage("asset/live-chat.png"),
      ),
      ItemsOfGradeProfilePage(
        onTap: () => Navigator.pushNamed(context, "Paysrecord"),
        desc: "المدفوعات",
        image: const AssetImage("asset/money.png"),
      ),
    ];
  }

  // =========================
  // 🔹 Menu Button
  // =========================

  Widget _buildMenuButton() {
    return MenueButton(
      onPressed: () {
        setState(() => _isOpenMenu = !_isOpenMenu);
      },
    );
  }

  // =========================
  // 🔹 Menu Panel
  // =========================

  Widget _buildMenu(List<ItemsOfGradeProfilePage> items) {
    return Menue(
      onHorizontalDragUpdate: (details) {
        if (_isOpenMenu && details.delta.dx > 8) {
          setState(() => _isOpenMenu = false);
        }
      },
      items: items,
      transform: Matrix4.translationValues(_isOpenMenu ? 0 : 300, 0, 0),
    );
  }

  // =========================
  // 🔹 Bottom Sheets
  // =========================

  Widget _buildBottomSheets() {
    return BlocConsumer<Cubitmanageordersstate, Statemanageordersstate>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is StateWaiting) {
          return sheet_new_order(
            modeldriverInfo: state.modeldriverInfo,
            modelorders: state.modelorders,
            idDoc: state.idDoc,
          );
        } else if (state is StateAcceptOrders) {
          return SheetAcceptedOrder(
            idDoc: state.idDoc,
            modeldriverInfo: state.modeldriverInfo,
            modelorders: state.modelorders,
          );
        } else if (state is StateArrived) {
          return Sheetarrivedmechanic(
            idDoc: state.idDoc,
            modeldriverInfo: state.modeldriverInfo,
            modelorders: state.modelorders,
          );
        } else if (state is StateDone) {
          return const messageEndedTask();
        }

        return SheetButtom();
      },
    );
  }
}
