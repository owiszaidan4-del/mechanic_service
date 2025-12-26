import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

List<Color> colors = [Colors.blueAccent, Colors.redAccent];
final hintColor = Colors.grey;
final currentUser = FirebaseAuth.instance.currentUser!.uid;
