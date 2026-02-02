class Modelorders {
  final String descreption;
  final String id;
  final String lat;
  final String lng;

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
      lat: json["lat"].toString(),
      lng: json["lng"].toString(),
      timeOrder: json["timeOrder"].toString(),
      wating: json["wating"],
    );
  }
}
