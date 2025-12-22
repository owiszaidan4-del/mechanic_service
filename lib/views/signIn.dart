import 'package:car_serves/constant.dart';
import 'package:car_serves/views/regesterView.dart';
import 'package:car_serves/widget/NameApp.dart';
import 'package:car_serves/widget/button_signIn.dart';
import 'package:car_serves/widget/customTextFeild.dart';
import 'package:car_serves/widget/logoApp.dart';
import 'package:car_serves/widget/statment_goToRegester.dart';
import 'package:car_serves/widget/statment_open.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Homeview1 extends StatefulWidget {
  @override
  State<Homeview1> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview1> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? email;
  String? password;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          autovalidateMode: autovalidateMode,
          key: globalKey,
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logoApp(),
              NameApp(size: 23),
              statment_open(txt: "ساعد غيرك على الطريق"),
              //email
              customTextFeild(
                inputFormatters: filtterEmailText,
                hint: "الايميل",
                icon: Icon(Icons.email),
                onSaved: (val) {
                  email = val;
                },
                validator: EmailValidat,
              ),
              //password
              customTextFeild(
                inputFormatters: filtterPasswordText,
                onSaved: (val) {
                  password = val;
                },
                validator: validatPassword,
                hint: "الباسوورد",
                icon: Icon(Icons.lock_outline),
              ),

              button_signIn(
                text: "تسجيل الدخول",
                onTap: () {
                  if (!globalKey.currentState!.validate()) {
                    globalKey.currentState!.save();
                    Navigator.pushNamed(context, 'HomeView');
                  } else {
                    setState(() {
                      autovalidateMode = AutovalidateMode.always;
                    });
                  }
                },
              ),
              statment_goToRegester(
                goToTxt: "سجل الان",
                text: "ما عندك حساب ؟",
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Regesterview()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? EmailValidat(value) {
    if (value?.isEmpty ?? true) {
      return "pleas enter Email";
    } else if (!value!.contains('@') || !value.endsWith(".com")) {
      return 'pleas enter valid email';
    } else {
      return null;
    }
  }

  String? validatPassword(val) {
    if (val?.isEmpty ?? true) {
      return "pleas Enter Password";
    } else if (val!.length < 10) {
      return 'password must have at least 10  letters';
    } else if (!val.contains(RegExp(r'[!@#$%^&*_=]'))) {
      return 'password must have  use at least one symple';
    } else {
      return null;
    }
  }
  //formatters

  List<TextInputFormatter> get filtterPasswordText {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-z!@#$%^&*_=0-9]')),
      LengthLimitingTextInputFormatter(20),
    ];
  }

  List<TextInputFormatter> get filtterEmailText {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z@.0-9]')),
      LengthLimitingTextInputFormatter(30),
    ];
  }
}
