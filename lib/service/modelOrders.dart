class Modelorders {
  final String descreption;
  final String id;
  final double lat;
  final double lng;

  final String timeOrder;
  final String stateOfRequest;

  Modelorders({
    required this.descreption,
    required this.id,
    required this.lat,
    required this.lng,
    required this.timeOrder,
    required this.stateOfRequest,
  });

  factory Modelorders.fromJson(json) {
    return Modelorders(
      descreption: json["descreption"],
      id: json["id"],
      lat: json["lat"],
      lng: json["lng"],
      timeOrder: json["timeOrder"].toString(),
      stateOfRequest: json["stateOfRequest"],
    );
  }
}
