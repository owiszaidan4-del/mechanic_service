class modelOrders_ {
  final String descreption;
  final String id;
  final double lat;
  final double lng;
  final double arrivaltime;
  final double distanceToDriver;
  final String placemark;
  final String timeOfassigend;

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
  });

  factory modelOrders_.fromJson(Map<String, dynamic> json) {
    return modelOrders_(
      arrivaltime: json["arrivaltime"],
      descreption: json["descreption"],
      distanceToDriver: json["distanceToDriver"],
      placemark: json["placemark"],
      timeOfassigend: json["timeOfassigend"].toString(),

      id: json["id"],
      lat: json["lat"],
      lng: json["lng"],
      timeOrder: json["timeOrder"].toString(),
      stateOfRequest: json["stateOfRequest"],
    );
  }
}
