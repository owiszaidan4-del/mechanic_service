import 'package:car_serves/views/regester_2.dart';
import 'package:car_serves/widget/NameApp.dart';
import 'package:car_serves/widget/button_signIn.dart';
import 'package:car_serves/widget/customTextFeild.dart';
import 'package:car_serves/widget/logoApp.dart';
import 'package:car_serves/widget/statment_goToRegester.dart';
import 'package:car_serves/widget/statment_open.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Regesterview extends StatefulWidget {
  @override
  State<Regesterview> createState() => _RegesterviewState();
}

class _RegesterviewState extends State<Regesterview> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? email;
  String? password;
  String? phoneNumber;
  String? confirmPassword;
  String? fullName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: 0),
        child: Center(
          child: Form(
            autovalidateMode: autovalidateMode,
            key: globalKey,
            child: SingleChildScrollView(
              child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  logoApp(),
                  NameApp(size: 18),
                  statment_open(txt: "سجل معنا الان"),
                  //full name
                  customTextFeild(
                    inputFormatters: filtterFullNameText,
                    hint: "ادخل اسمك من اربع مقاطع",
                    icon: Icon(Icons.person),
                    onSaved: (val) {
                      fullName = val;
                    },
                    validator: fullNameValidat,
                  ),
                  ///////////phoneNumber
                  customTextFeild(
                    inputFormatters: filtterPhoneNumberText,
                    hint: "رقم الهاتف",
                    icon: Icon(Icons.phone),
                    onSaved: (val) {
                      phoneNumber = val;
                    },
                    validator: phoneNumberValidat,
                  ),
                  /////////email
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
                    hint: "كلمة السر",
                    icon: Icon(Icons.lock_outline),
                    onSaved: (val) {
                      password = val;
                    },
                    validator: validatPassword,
                  ),
                  //password
                  customTextFeild(
                    inputFormatters: filtterPasswordText,
                    onSaved: (val) {
                      confirmPassword = val;
                    },
                    validator: validatPassword,
                    hint: "تاكيد كلمة السر",
                    icon: Icon(Icons.lock),
                  ),

                  button_signIn(
                    text: "...تابع",
                    onTap: () {
                      if (globalKey.currentState!.validate()) {
                        globalKey.currentState!.save();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Regester2(
                              email: email!,
                              password: password!,
                              phoneNumber: phoneNumber!,
                              confirmPassword: confirmPassword!,
                              fullName: fullName!,
                            ),
                          ),
                        );
                      } else {
                        setState(() {
                          autovalidateMode = AutovalidateMode.always;
                        });
                      }
                    },
                  ),
                  statment_goToRegester(
                    goToTxt: "سجل دخول",
                    text: "عندك حساب؟",
                    ontap: () {
                      Navigator.pushNamed(context, "signInView", arguments: {});
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

  String? EmailValidat(value) {
    if (value?.isEmpty ?? true) {
      return "pleas enter Email";
    } else if (!value!.contains('@') || !value.endsWith(".com")) {
      return 'pleas enter valid email';
    } else {
      return null;
    }
  }

  String? fullNameValidat(value) {
    if (value?.isEmpty ?? true) {
      return "pleas enter full name";
    } else if (!value!.contains(' ') || value.endsWith(" ")) {
      return 'pleas enter valid name';
    } else {
      return null;
    }
  }

  String? phoneNumberValidat(value) {
    if (value?.isEmpty ?? true) {
      return "pleas enter phoneNumber";
    } else if (value.toString().length < 10) {
      return 'pleas enter valid phoneNumber';
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

  String? validatConfirmPassword(val) {
    if (val?.isEmpty ?? true) {
      return "pleas confirm Password";
    } else if (val != password) {
      return 'كلمة السر غير متطابقة';
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

  List<TextInputFormatter> get filtterFullNameText {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),

      LengthLimitingTextInputFormatter(60),
    ];
  }

  List<TextInputFormatter> get filtterPhoneNumberText {
    return [
      FilteringTextInputFormatter.digitsOnly,

      LengthLimitingTextInputFormatter(10),
    ];
  }
}
