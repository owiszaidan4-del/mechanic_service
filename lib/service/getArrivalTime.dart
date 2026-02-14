import 'dart:developer';

import 'package:dio/dio.dart';

class Getarrivaltime {
  final List<double> lngLatMech;
  final List<double> lngLatDriver;

  Getarrivaltime({required this.lngLatMech, required this.lngLatDriver});
  Future<double> getarrivaltime() async {
    final key =
        'eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6IjRkZTg0OTdkNzQ3MjQ2YzQ5MzdkMmZmOTI5ZDA4NTMzIiwiaCI6Im11cm11cjY0In0=';
    final dio = Dio();
    try {
      final response = await dio.post(
        "https://api.openrouteservice.org/v2/matrix/driving-car",
        options: Options(
          headers: {
            "Authorization": key,
            "Content-Type": "application/json; charset=utf-8",
          },
        ),
        data: {
          "locations": [
            lngLatMech, // [lon, lat]
            lngLatDriver,
          ],
          "metrics": ["duration"],
          "units": "km",
        },
      );
      final double arrivaltime = await response.data["durations"][0][1];
      final String arrivaltimeFormat = computeArrivaltime(time: arrivaltime);
      log(arrivaltimeFormat);
      return arrivaltime;
    } catch (e) {
      log(e.toString());
      return 0;
    }
  }

  computeArrivaltime({required double time}) {
    Duration dur = Duration(seconds: time.round());

    int hours = dur.inHours;
    int minutes = dur.inMinutes.remainder(60);

    if (hours > 0) {
      return "$hours ساعات و $minutes دقيقة";
    } else {
      return "$minutes دقيقة";
    }
  }
}
