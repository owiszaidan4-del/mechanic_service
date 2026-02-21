import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class modelOrders_ {
  final String descreption;
  final String id;
  final double lat;
  final double lng;
  final double arrivaltime;
  final double distanceToDriver;
  final String placemark;
  final Timestamp? timeOfassigend;
  final Timestamp? timeCompleatedOrder;
  final double wages;

  final String timeOrder;
  final String stateOfRequest;

  const modelOrders_({
    required this.descreption,
    required this.id,
    required this.lat,
    required this.lng,
    required this.timeOrder,
    required this.stateOfRequest,
    required this.placemark,
    required this.distanceToDriver,
    required this.timeOfassigend,
    required this.arrivaltime,
    required this.timeCompleatedOrder,
    required this.wages,
  });

  factory modelOrders_.fromJson(Map<String, dynamic> json) {
    return modelOrders_(
      arrivaltime: json["arrivaltime"],
      descreption: json["descreption"],
      distanceToDriver: json["distanceToDriver"],
      placemark: json["placemark"],
      timeOfassigend: json["timeOfassigend"],
      timeCompleatedOrder: json["timeCompleatedOrder"],
      id: json["id"],
      lat: json["lat"],
      lng: json["lng"],
      timeOrder: json["timeOrder"].toString(),
      stateOfRequest: json["stateOfRequest"],
      wages: json["wages"] ?? 0.0,
    );
  }
}
