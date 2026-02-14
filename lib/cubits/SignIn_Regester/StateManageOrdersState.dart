import 'package:car_serves/service/modelDriverInfo.dart';
import 'package:car_serves/service/modelOrders.dart';
import 'package:car_serves/service/modelOrders_.dart';

class Statemanageordersstate {}

class InetialStete extends Statemanageordersstate {}

class StateAcceptOrders extends Statemanageordersstate {
  final ModeldriverInfo modeldriverInfo;
  final modelOrders_ modelorders;
  final String idDoc;
  StateAcceptOrders({
    required this.modeldriverInfo,
    required this.modelorders,
    required this.idDoc,
  });
}

class StateRejectOrders extends Statemanageordersstate {}

class StateWaiting extends Statemanageordersstate {
  final ModeldriverInfo modeldriverInfo;
  final modelOrders_ modelorders;
  final String idDoc;
  StateWaiting({
    required this.modeldriverInfo,
    required this.modelorders,
    required this.idDoc,
  });
}

class StateArrived extends Statemanageordersstate {
  final ModeldriverInfo modeldriverInfo;
  final modelOrders_ modelorders;
  final String idDoc;
  StateArrived({
    required this.modeldriverInfo,
    required this.modelorders,
    required this.idDoc,
  });
}

class StateProplem extends Statemanageordersstate {
  final String err;

  StateProplem({required this.err});
}
