class Modelorders {
  final String descreption;
  final String id;
  final double lat;
  final double lng;

  final String timeOrder;
  final bool wating;

  Modelorders({
    required this.descreption,
    required this.id,
    required this.lat,
    required this.lng,
    required this.timeOrder,
    required this.wating,
  });

  factory Modelorders.fromJson(json) {
    return Modelorders(
      descreption: json["descreption"],
      id: json["id"],
      lat: json["lat"],
      lng: json["lng"],
      timeOrder: json["timeOrder"].toString(),
      wating: json["state"],
    );
  }
}
