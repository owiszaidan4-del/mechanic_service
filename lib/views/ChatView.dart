import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_serves/constant.dart';
import 'package:car_serves/service/Chat/Getmessage.dart';
import 'package:car_serves/service/Getimagefromedevice.dart';
import 'package:car_serves/service/modelDriverInfo.dart';
import 'package:car_serves/service/modelOrders_.dart';
import 'package:car_serves/widget/chat/Messagfromsomeonecontainer.dart';
import 'package:car_serves/widget/chat/ReplayMessage.dart';
import 'package:car_serves/widget/chat/TypingMessage.dart';
import 'package:car_serves/widget/chat/myMessageContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:image_cropper/image_cropper.dart';

class Chatview extends StatefulWidget {
  Chatview({
    required this.userId,
    required this.modelDrider,
    required this.chatWithAdmin,
    required this.initText,
  });
  final String? userId;
  final ModeldriverInfo modelDrider;
  bool chatWithAdmin = false;
  final String initText;
  //final Modelcurrentuser userModel;
  @override
  State<Chatview> createState() => _ChatviewState();
}

class _ChatviewState extends State<Chatview> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController.text = widget.initText;
    message = widget.initText;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    super.dispose();
  }

  var message;
  String? sellectReplayMessage;
  String? getReplayMessage;
  File? cheackImage;
  TextEditingController textEditingController = TextEditingController();
  ScrollController? controller = ScrollController();
  Widget build(BuildContext context) {
    // var argument =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String userId = widget.userId ?? "";

    String chatId = Getmessage(userId: userId).getChatId();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: widget.chatWithAdmin
            ? appBarOfChatView(
                chatWithAdmin: widget.chatWithAdmin,
                text: "التحدث مع الدعم",
                urlImage: "asset/admin.png",
              )
            : appBarOfChatView(
                chatWithAdmin: widget.chatWithAdmin,
                urlImage: widget.modelDrider.urlImage,
                text: widget.modelDrider.full_name,
              ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //List builder
          //
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Chat")
                    .doc(chatId)
                    .collection("messages")
                    .orderBy("cereatedAt", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  //check data is find or no message
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    var alldata = snapshot.data!.docs;
                    //check seen my message or not
                    getSeenState(snapshot, alldata, userId);

                    ///show message
                    return ListView.builder(
                      controller: controller,
                      reverse: true,
                      itemCount: alldata.length,
                      itemBuilder: (context, index) {
                        //cheke message from me
                        if (alldata[index]["userId"] == currentUser) {
                          //cheack replay message
                          if (snapshot.data!.docs[index].data().containsKey(
                            "replaymessage",
                          )) {
                            //return message whith replay
                            return replayForMyMessage(alldata, index);
                          } else {
                            //return message with out replay
                            return returnMyMessage(alldata, index);
                          }
                        } else {
                          //message from any user
                          //check replay or not
                          if (snapshot.data!.docs[index].data().containsKey(
                            "replaymessage",
                          )) {
                            //return mesage whith replay
                            return messageReplayFromSomeone(alldata, index);
                          } else {
                            //returnv message without replay
                            return messageFromeSomeOne(alldata, index);
                          }
                        }
                      },
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    //if no message betwen any user return this
                    return Center(
                      child: Text(
                        "no message untl now",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }
                },
              ),
            ),
          ),

          //replay message
          if (sellectReplayMessage != null)
            ReplayMessage(
              message: sellectReplayMessage!,
              closeContenar: () {
                setState(() {
                  sellectReplayMessage = null;
                });
              },
            ),
          //typing Mwssages
          TypingMessage(
            addFile: () async {
              await sendImageChat(userId);
            },
            textEditingController: textEditingController,
            onChanged: (val) {
              cheackImage = null;
              message = val;
            },
            //send message
            sendBouton: () {
              if (message != null) {
                if (controller!.hasClients) {
                  controller!.animateTo(
                    controller!.position.minScrollExtent,
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInOut,
                  );
                }

                if (sellectReplayMessage != null) {
                  Getmessage(userId: userId).replayToMessage(
                    message: message,
                    repmesaage: sellectReplayMessage,
                  );
                } else {
                  Getmessage(userId: userId).sendMessages(message: message);
                }

                setState(() {
                  sellectReplayMessage = null;
                });
                textEditingController.clear();
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> sendImageChat(String userId) async {
    var fileFromDev = await Getimagefromedevice(
      cropStyle: CropStyle.rectangle,
      lockAspectRatio: true,
      cropAspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    ).ImageFromDevice();
    if (fileFromDev != null) {
      File Image = File(fileFromDev);
      cheackImage = Image;
      log(Image.path);
      Getmessage(
        userId: userId,
      ).sendFile(Image, FirebaseAuth.instance.currentUser!.uid);
    }
  }

  Messagfromsomeonecontainer messageFromeSomeOne(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> alldata,
    int index,
  ) {
    return Messagfromsomeonecontainer(
      replayMessage: null,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          setState(() {
            sellectReplayMessage = alldata[index]["message"];
          });
        }
        return false;
      },

      alldata: alldata[index]["message"],
    );
  }

  Messagfromsomeonecontainer messageReplayFromSomeone(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> alldata,
    int index,
  ) {
    return Messagfromsomeonecontainer(
      replayMessage: alldata[index]["replaymessage"],
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          setState(() {
            sellectReplayMessage = alldata[index]["message"];
          });
        }
        return false;
      },

      alldata: alldata[index]["message"],
    );
  }

  myMessageContainer returnMyMessage(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> alldata,
    int index,
  ) {
    return myMessageContainer(
      replayMessage: null,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          setState(() {
            sellectReplayMessage = alldata[index]["message"];
          });
        }
        return false;
      },
      time: alldata[0]["cereatedAt"] ?? Timestamp.now(),
      isseen:
          alldata[0]["userId"] == FirebaseAuth.instance.currentUser!.uid &&
              index == 0
          ? alldata[0]["isSeen"]
          : false,
      alldata: alldata[index]["message"],
    );
  }

  myMessageContainer replayForMyMessage(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> alldata,
    int index,
  ) {
    return myMessageContainer(
      replayMessage: alldata[index]["replaymessage"],
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          setState(() {
            sellectReplayMessage = alldata[index]["message"];
          });
        }
        return false;
      },
      time: alldata[0]["cereatedAt"] ?? Timestamp.now(),
      isseen:
          alldata[0]["userId"] == FirebaseAuth.instance.currentUser!.uid &&
              index == 0
          ? alldata[0]["isSeen"]
          : false,
      alldata: alldata[index]["message"],
    );
  }

  void getSeenState(
    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
    List<QueryDocumentSnapshot<Map<String, dynamic>>> alldata,
    String userId,
  ) {
    if (snapshot.connectionState == ConnectionState.active) {
      if (alldata[0]["userId"] != FirebaseAuth.instance.currentUser!.uid) {
        Getmessage(userId: userId).getSeenState(alldata[0].id);
      }
    }
  }

  //   AppBar AppBarChatView(Modelcurrentuser userModel) {
  //     return AppBar(
  //       title: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,

  //         children: [
  //           profileImageUser(userModel: userModel, radious: 20),
  //           FullName_UserName(userModel: userModel),
  //         ],
  //       ),
  //     );
  //   }
  // }
}

class appBarOfChatView extends StatelessWidget {
  appBarOfChatView({
    super.key,
    required this.urlImage,
    required this.text,
    required this.chatWithAdmin,
  });
  final String urlImage;
  final String text;
  bool chatWithAdmin = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        CircleAvatar(
          radius: MediaQuery.of(context).size.width * 0.07,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: chatWithAdmin
                ? Image.asset(urlImage, fit: BoxFit.cover)
                : Image.network(urlImage),
          ),
        ),
        Text(text, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
