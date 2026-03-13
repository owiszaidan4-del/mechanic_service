import 'dart:async';
import 'dart:developer';

import 'package:car_serves/views/signIn.dart';
import 'package:car_serves/widget/button_signIn.dart';
import 'package:car_serves/widget/customTextFeild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Editpasswordview extends StatefulWidget {
  @override
  State<Editpasswordview> createState() => _EditpasswordviewState();
}

class _EditpasswordviewState extends State<Editpasswordview> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? email;
  String? password;
  String? emailVerified;
  bool issend = false;
  int temp = 30;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تعديل كلمة السر"), centerTitle: true),
      body: Form(
        key: globalKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          spacing: 10,
          children: [
            Center(
              child: customTextFeild(
                inputFormatters: filtterEmailText,
                hint: "الايميل",
                err: emailVerified,
                icon: Icon(Icons.email),
                onSaved: (val) {
                  email = val;
                },
                textDescreption: "سيتم ارسال رابط لتغيير كلمة السر",
                validator: EmailValidat,
              ),
            ),
            if (issend)
              button_signIn(text: "تم الارسال", onTap: () {})
            else
              button_signIn(
                text: "ارسال",
                onTap: () async {
                  if (globalKey.currentState!.validate()) {
                    globalKey.currentState!.save();

                    // }
                    try {
                      await FirebaseAuth.instance.sendPasswordResetEmail(
                        email: email!,
                      );
                      setState(() {
                        issend = true;
                      });
                      timer();
                    } catch (e) {
                      log(e.toString());
                    }
                  } else {
                    setState(() {
                      autovalidateMode = AutovalidateMode.always;
                    });
                  }
                },
              ),
            if (issend)
              Text(
                "اعادة ارسال بعد $temp",
                style: TextStyle(color: Colors.black.withOpacity(0.3)),
              ),
          ],
        ),
      ),
    );
  }

  void timer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        temp -= 1;
      });

      // if (temp < 0) {
      //   timer.cancel();
      //   return;
      // }
      if (temp == 0) {
        issend = false;
        temp = 30;
        timer.cancel();
      }
    });
  }
}
