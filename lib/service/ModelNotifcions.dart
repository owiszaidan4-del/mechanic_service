import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Modelnotifcions {
  final String title;
  final String targetUserId;
  final String type;
  final bool isRead;

  final String body;
  final String createdAt;
  const Modelnotifcions({
    required this.body,
    required this.targetUserId,
    required this.title,
    required this.type,
    required this.isRead,

    required this.createdAt,
  });
  factory Modelnotifcions.fromJson(QueryDocumentSnapshot<Object?> json) {
    final dd = json["createdAt"] as Timestamp;
    DateTime dateTime = dd.toDate();
    final createdAt = DateFormat.yMd().format(dateTime).toString();
    return Modelnotifcions(
      body: json["body"],
      targetUserId: json["targetUserId"],
      title: json["title"],
      type: json["type"],
      isRead: json["isRead"],
      createdAt: createdAt,
    );
  }
}
