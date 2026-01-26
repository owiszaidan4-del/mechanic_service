class Modelgetalluserinfo {
  final String city;
  final String fullName;
  final String phoneNumber;
  final String workShopName;
  final String workadress;
  final String registerDate;
  final String specialization;

  Modelgetalluserinfo({
    required this.city,
    required this.fullName,
    required this.phoneNumber,
    required this.registerDate,
    required this.workShopName,
    required this.workadress,
    required this.specialization,
  });
  factory Modelgetalluserinfo.fromJson(Map<String, dynamic> json) {
    return Modelgetalluserinfo(
      city: json["city"],
      fullName: json["full_name"],
      phoneNumber: json["phoneNumber"],
      registerDate: json["registerDate"].toString(),
      workShopName: json["workShopName"],
      workadress: json["workadress"],
      specialization: json["specialization"],
    );
  }
}
