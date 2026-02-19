class ModeldriverInfo {
  final String careModel;
  final String email;
  final String full_name;
  final String phoneNumber;
  final String registerDate;
  final String roule;
  final String urlImage;
  final String userid;
  final String carId;

  ModeldriverInfo({
    required this.careModel,
    required this.email,
    required this.full_name,
    required this.phoneNumber,
    required this.registerDate,
    required this.roule,
    required this.urlImage,
    required this.userid,
    required this.carId,
  });

  factory ModeldriverInfo.fromJson(Map<String, dynamic> json) {
    return ModeldriverInfo(
      carId: json["json"] ?? "",
      careModel: json["careModel"],
      email: json["email"],
      full_name: json["full_name"],
      phoneNumber: json["phoneNumber"],
      registerDate: json["registerDate"].toString(),
      roule: json["roule"],
      urlImage: json["urlImage"] ?? "",
      userid: json["userid"],
    );
  }
}
