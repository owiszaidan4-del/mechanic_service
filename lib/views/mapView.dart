import 'dart:async';

import 'package:car_serves/constant.dart';
import 'package:car_serves/cubits/SignIn_Regester/StateManageOrdersState.dart';
import 'package:car_serves/cubits/SignIn_Regester/cubitGetStateOfWork.dart';
import 'package:car_serves/cubits/SignIn_Regester/cubitManageOrdersState.dart';
import 'package:car_serves/cubits/SignIn_Regester/stateGetStateOfWork.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapview extends StatefulWidget {
  @override
  State<Mapview> createState() => _MapviewState();
}

class _MapviewState extends State<Mapview> {
  LatLng initialPostion = LatLng(31.945368, 35.928371);

  late Marker myMarker;
  Marker? driverMarker;
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

  @override
  void dispose() {
    positionStream?.cancel();
    googleMapController.dispose();
    super.dispose();
  }

  StreamSubscription<Position>? positionStream;
  late GoogleMapController googleMapController;
  bool statework = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<Cubitmanageordersstate, Statemanageordersstate>(
        listener: (context, state) {
          if (state is StateAcceptOrders || state is StateArrived) {
            final order = state is StateAcceptOrders
                ? state.modelorders
                : (state as StateArrived).modelorders;

            setState(() {
              driverMarker = Marker(
                markerId: const MarkerId("driverMarker"),
                position: LatLng(order.lat, order.lng),
                icon: AssetMapBitmap(
                  "asset/carDriver.png",
                  width: 48,
                  height: 48,
                ),
                anchor: const Offset(0.5, 0.5),
              );
            });
          }
        },
        child: BlocListener<Cubitgetstateofwork, Stategetstateofwork>(
          listener: (context, state) {
            if (state is StateSucssesgetstateOfWork) {
              statework = state.stateOfWork;
            }
          },
          child: GoogleMap(
            onMapCreated: (controller) {
              googleMapController = controller;

              getMyPostionStream();
            },

            initialCameraPosition: CameraPosition(
              target: initialPostion,
              zoom: 15,
            ),
            markers: {myMarker, if (driverMarker != null) driverMarker!},
            onCameraMove: (position) {},
            onTap: (postion) {},
            rotateGesturesEnabled: true,
            myLocationEnabled: false,
          ),
        ),
      ),
    );
  }

  void getMyPostionStream() {
    positionStream =
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 5,
          ),
        ).listen((Position postion) {
          sendMyLocationToFireStore(postion.latitude, postion.longitude);

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

  sendMyLocationToFireStore(double latitude, double longitude) {
    if (statework) {
      FirebaseFirestore.instance
          .collection("mechanicOnline")
          .doc(currentUser)
          .update(({"lat": latitude, "lng": longitude}));
    } else {
      FirebaseFirestore.instance
          .collection("mechanicLocation")
          .doc(currentUser)
          .delete();
    }
  }

  // FirebaseFirestore.instance
  //     .collection("mechanicOnline")
  //     .doc(currentUser)
  //     .get()
  //     .then((value) {
  //       if (value.exists) {
  //         final bool stateWork = value.data()!["stateOfWork"];
  //         if (stateWork) {
  //           FirebaseFirestore.instance
  //               .collection("mechanicLocation")
  //               .doc(currentUser)
  //               .set(({"lat": latitude, "lng": longitude}));
  //         }
  //       }
  //     });
}

  //   void addMarker(Marker mark){
  // List<Marker>

  //   }

