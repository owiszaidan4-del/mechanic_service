class Modelgetalluserinfo {
  final String city;
  final String fullName;
  final String phoneNumber;
  final String workShopName;
  final String workadress;
  final String registerDate;
  final String specialization;
  final String userId;
  final String performance;
  final String urlImage;

  Modelgetalluserinfo({
    required this.urlImage,
    required this.userId,
    required this.city,
    required this.fullName,
    required this.phoneNumber,
    required this.registerDate,
    required this.workShopName,
    required this.workadress,
    required this.specialization,
    required this.performance,
  });
  factory Modelgetalluserinfo.fromJson(Map<String, dynamic> json) {
    return Modelgetalluserinfo(
      urlImage:
          json["urlImage"] ??
          "https://firebasestorage.googleapis.com/v0/b/owis-412911.firebasestorage.app/o/defultImageUsers%2Fuser-image-with-black-background.png?alt=media&token=ce59134b-2fbf-4828-9238-e16d0cd2fd32",
      city: json["city"],
      fullName: json["full_name"],
      phoneNumber: json["phoneNumber"],
      registerDate: json["registerDate"].toString(),
      workShopName: json["workShopName"],
      workadress: json["workadress"],
      specialization: json["specialization"],
      userId: json["userId"].toString(),
      performance: json["performance"].toString(),
    );
  }
}
