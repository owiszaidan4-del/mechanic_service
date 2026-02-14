import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class myMessageContainer extends StatelessWidget {
  myMessageContainer({
    super.key,
    required this.alldata,
    required this.isseen,
    required this.time,

    required this.confirmDismiss,
    required this.replayMessage,
  });
  final Timestamp time;
  final String alldata;
  final bool isseen;
  final String? replayMessage;
  Future<bool?> Function(DismissDirection)? confirmDismiss;
  @override
  Widget build(BuildContext context) {
    String durationtime = gettime(time);
    return Align(
      alignment: Alignment.centerRight,
      child: Dismissible(
        key: Key("owis"),
        direction: DismissDirection.endToStart,

        dismissThresholds: {DismissDirection.endToStart: 0.5},
        confirmDismiss: confirmDismiss,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth:
                MediaQuery.of(context).size.width *
                0.7, // حد أقصى 70% من الشاشة
          ),
          child: Column(
            children: [
              //replay message
              if (replayMessage != null)
                replayMessage!.contains(
                      "https://firebasestorage.googleapis.com",
                    )
                    ? Container(
                        padding: EdgeInsets.only(right: 10),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),

                          boxShadow: [
                            BoxShadow(
                              // offset: Offset(3, 0),
                              color: Colors.black,
                              spreadRadius: 2,

                              blurStyle: BlurStyle.outer,
                            ),
                          ],
                          image: DecorationImage(
                            opacity: 0.5,
                            image: CachedNetworkImageProvider(replayMessage!),
                          ),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          replayMessage!,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 8,
                          ),
                        ),
                      ),
              //message
              Container(
                margin: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
                // padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: alldata.endsWith("jpg")
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          image: DecorationImage(
                            image: FileImage(File(alldata)),
                          ),
                        ),
                        height: 150,
                        width: 150,
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.black),
                        ),
                      )
                    : alldata.contains("https://firebasestorage.googleapis.com")
                    ? SizedBox(
                        height: 150,
                        width: 150,
                        child: CachedNetworkImage(
                          fadeInDuration: Duration.zero,
                          fadeOutDuration: Duration.zero,
                          useOldImageOnUrlChange: true,

                          imageUrl: alldata,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          alldata,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          softWrap: true,
                        ),
                      ),
              ),
              if (isseen)
                Text(
                  "seen $durationtime",
                  style: TextStyle(color: Colors.grey, fontSize: 8),
                ),
            ],
          ),
        ),
      ),
    );
  }

  gettime(Timestamp time) {
    int startTime = time.seconds;
    int endTime = Timestamp.now().seconds;
    int defInsecond = endTime - startTime;
    Duration since = Duration(seconds: defInsecond);
    print("${since.inMinutes}");
    if (since.inMinutes <= 0) {
      return "now";
    } else if (since.inMinutes < 60) {
      return "${since.inMinutes}mins ago";
    } else if (since.inMinutes >= 60 && since.inMinutes < 1440) {
      return "${since.inHours}hour ago";
    } else {
      return "${since.inDays}day ago";
    }
  }
}
