import 'package:car_serves/views/Settings/EditPasswordView.dart';
import 'package:car_serves/views/Settings/editProfileImage.dart';
import 'package:car_serves/views/Settings/rowSettingsWidget.dart';
import 'package:car_serves/views/signIn.dart';
import 'package:car_serves/widget/setting/cardSetting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Settingsview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الاعدادات"), centerTitle: true),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                cardSetting(
                  titel: "الاعدادات",
                  children: [
                    rowSettingsWidget(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Editprofileimage(),
                          ),
                        );
                      },
                      text: "الملف الشخصي",
                      urlImage: "asset/profile1.png",
                    ),
                    rowSettingsWidget(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Editpasswordview(),
                          ),
                        );
                      },
                      text: "كلمة السر",
                      urlImage: "asset/password.png",
                    ),
                    rowSettingsWidget(
                      onTap: () {},
                      text: "الاشعارات",
                      urlImage: "asset/notification.png",
                    ),
                  ],
                ),
                cardSetting(
                  titel: "المزيد",
                  children: [
                    rowSettingsWidget(
                      urlImage: "asset/help-web-button.png",
                      text: "المساعدة",
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Homeview1()),
                    (route) => false,
                  );
                },
                child: Text("تسجيل خروج", style: TextStyle(color: Colors.red)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
