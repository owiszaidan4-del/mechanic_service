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
                      onTap: () {},
                      text: "الملف الشخصي",
                      urlImage: "asset/profile1.png",
                    ),
                    rowSettingsWidget(
                      onTap: () {},
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
                child: Text("تسجيل خروج", style: TextStyle(color: Colors.red)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class cardSetting extends StatelessWidget {
  const cardSetting({super.key, required this.titel, required this.children});
  final String titel;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10),
          ],
        ),
        child: Column(
          children: [
            Text(titel),
            Divider(),
            Column(children: children),
          ],
        ),
      ),
    );
  }
}

class rowSettingsWidget extends StatelessWidget {
  const rowSettingsWidget({
    super.key,
    required this.urlImage,
    required this.text,
    required this.onTap,
  });
  final String urlImage;
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 8,
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white,
                  child: Image.asset(urlImage, color: Colors.black),
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
              ],
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Icon(
                size: 13,
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
