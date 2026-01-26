import 'package:car_serves/service/modelGetAllUserInfo.dart';

class StategetallInfousers {}

class InetialState extends StategetallInfousers {}

class StateSucsess extends StategetallInfousers {
  final Modelgetalluserinfo allInfoUsers;

  StateSucsess({required this.allInfoUsers});
}

class StateFaield extends StategetallInfousers {
  final String errType;

  StateFaield({required this.errType});
}

class StateLoad extends StategetallInfousers {}
