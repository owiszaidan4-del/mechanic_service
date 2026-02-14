import 'package:flutter/material.dart';

class TypingMessage extends StatelessWidget {
  TypingMessage({
    super.key,
    required this.onChanged,
    required this.sendBouton,
    required this.textEditingController,
    required this.addFile,
  });
  Function(String)? onChanged;
  void Function()? sendBouton;
  void Function()? addFile;
  TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      //textField
      child: TextField(
        controller: textEditingController,
        style: TextStyle(fontSize: 10),
        textAlign: TextAlign.start,
        onChanged: onChanged,
        cursorHeight: 18,

        decoration: InputDecoration(
          suffixIcon: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: addFile, icon: Icon(Icons.image)),
                IconButton(
                  onPressed: sendBouton,
                  icon: Icon(Icons.send, color: Colors.blueAccent),
                ),
              ],
            ),
          ),
          prefixIcon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.camera_alt, color: Colors.blueAccent),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hint: Text(
            "Messag...",
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
