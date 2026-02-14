import 'dart:developer';

import 'package:car_serves/service/modelDriverInfo.dart';
import 'package:car_serves/views/ChatView.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class personalInfo_of_sheet_new_order extends StatelessWidget {
  ModeldriverInfo modeldriverInfo;
  final String userId;
  personalInfo_of_sheet_new_order({
    super.key,
    required this.modeldriverInfo,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        CircleAvatar(
          radius: 25,
          child: Image.network(modeldriverInfo.urlImage, fit: BoxFit.cover),
        ),
        Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                modeldriverInfo.full_name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                modeldriverInfo.careModel,
                style: TextStyle(fontSize: 10, overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () async {
                  await goTOcallDriver();
                },
                child: Image.asset(
                  "asset/phone (1).png",
                  width: MediaQuery.of(context).size.width * 0.08,
                  color: Colors.green,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Chatview(
                        userId: userId,
                        modelDrider: modeldriverInfo,
                        chatWithAdmin: false,
                        initText: "",
                      ),
                    ),
                  );
                },
                child: Image.asset(
                  "asset/chat-bubble.png",
                  width: MediaQuery.of(context).size.width * 0.08,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> goTOcallDriver() async {
    final Uri uri = Uri.parse("tel:${modeldriverInfo.phoneNumber}");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      log("cant LaunchUrl");
    }
  }
}
