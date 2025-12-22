import 'dart:convert';
import 'dart:developer';

import 'package:car_serves/service/getMyLocation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class Mapview extends StatefulWidget {
  @override
  State<Mapview> createState() => _MapviewState();
}

class _MapviewState extends State<Mapview> {
  LatLng initialPostion = LatLng(31.945368, 35.928371);

  late Marker myMarker;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    myMarker = Marker(
      markerId: MarkerId("myMarker"),
      position: initialPostion,
      icon: AssetMapBitmap("asset/car.png", width: 48, height: 48),
      anchor: Offset(0.5, 0.5),
    );
  }

  late GoogleMapController googleMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (controller) async {
          googleMapController = controller;

          getMyPostionStream();
        },

        initialCameraPosition: CameraPosition(target: initialPostion, zoom: 15),
        markers: {myMarker},
        onCameraMove: (position) {},
        onTap: (postion) {},

        myLocationEnabled: false,
      ),
    );
  }

  void getMyPostionStream() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((Position postion) {
      setState(() {
        myMarker = myMarker.copyWith(
          positionParam: LatLng(postion.latitude, postion.longitude),
        );
      });
      googleMapController.animateCamera(
        CameraUpdate.newLatLng(LatLng(postion.latitude, postion.longitude)),
      );
    });
  }
  //   void addMarker(Marker mark){
  // List<Marker>

  //   }
}
