import 'package:car_serves/views/HomeView.dart';
import 'package:car_serves/views/signIn.dart';
import 'package:car_serves/views/regesterView.dart';
import 'package:car_serves/views/regester_2.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const car_serves());
}

class car_serves extends StatelessWidget {
  const car_serves({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'signInView',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(239, 255, 255, 255),
      ),
      routes: {
        'HomeView': (context) => Homeview2(),
        "regesterView": (context) => Regesterview(),
        "signInView": (context) => Homeview1(),
        "Regester2": (context) => Regester2(),
      },
      debugShowCheckedModeBanner: false,
      home: Homeview1(),
    );
  }
}
