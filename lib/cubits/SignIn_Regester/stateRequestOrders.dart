import 'package:car_serves/service/modelDriverInfo.dart';
import 'package:car_serves/service/modelOrders.dart';

class Staterequestorders {}

class InetialStete extends Staterequestorders {}

class StateAcceptOrders extends Staterequestorders {}

class StateRejectOrders extends Staterequestorders {}

class StateWaiting extends Staterequestorders {
  final ModeldriverInfo modeldriverInfo;
  final Modelorders modelorders;
  StateWaiting({required this.modeldriverInfo, required this.modelorders});
}

class StateProplem extends Staterequestorders {
  final String err;

  StateProplem({required this.err});
}
