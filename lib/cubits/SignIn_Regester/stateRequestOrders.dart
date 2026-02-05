import 'package:car_serves/service/modelDriverInfo.dart';

class Staterequestorders {}

class InetialStete extends Staterequestorders {}

class StateAcceptOrders extends Staterequestorders {}

class StateRejectOrders extends Staterequestorders {}

class StateWaiting extends Staterequestorders {
  ModeldriverInfo modeldriverInfo;
  StateWaiting({required this.modeldriverInfo});
}

class StateProplem extends Staterequestorders {
  final String err;

  StateProplem({required this.err});
}
