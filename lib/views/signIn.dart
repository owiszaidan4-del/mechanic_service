import 'dart:developer';

import 'package:car_serves/cubits/SignIn_Regester/States_RegesterAuthTransaction.dart';
import 'package:car_serves/cubits/SignIn_Regester/cubit_RegesterAuthTransaction.dart';
import 'package:car_serves/views/regesterView.dart';
import 'package:car_serves/widget/NameApp.dart';
import 'package:car_serves/widget/button_signIn.dart';
import 'package:car_serves/widget/customTextFeild.dart';
import 'package:car_serves/widget/logoApp.dart';
import 'package:car_serves/widget/statment_goToRegester.dart';
import 'package:car_serves/widget/statment_open.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: SingleChildScrollView(
        child:
            BlocListener<
              CubitRegesterauthtransaction,
              StatesRegesterauthtransaction
            >(
              listener: (context, state) {
                if (state is state_success) {
                  void showLoadingDialog(BuildContext context) {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) =>
                          const Center(child: CircularProgressIndicator()),
                    );
                  }

                  // لإغلاقه
                  Navigator.of(context).pop();

                  Navigator.pushNamed(context, "HomeView");
                } else if (state is state_failed) {
                  log("sssssss");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.typeFailed),
                      duration: Duration(seconds: 10),
                    ),
                  );
                }
              },

              child: Center(
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
                          if (globalKey.currentState!.validate()) {
                            globalKey.currentState!.save();

                            BlocProvider.of<CubitRegesterauthtransaction>(
                              context,
                            ).SignInAuth(email: email!, password: password!);
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
                            MaterialPageRoute(
                              builder: (context) => Regesterview(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
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
