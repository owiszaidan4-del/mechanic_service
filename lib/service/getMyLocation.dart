import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class Getmylocation {
  checkPermution() async {
    PermissionStatus state = await Permission.location.status;

    if (state.isDenied || state.isRestricted) {
      Permission.location.request();
    } else if (state.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<Position> getcurrentLocation() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
