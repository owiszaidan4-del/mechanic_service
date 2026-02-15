import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class widgetTake_Photo extends StatelessWidget {
  widgetTake_Photo({
    super.key,
    required this.text,
    required this.onTap,
    required this.isDawonload,
    required this.onPressed,
  });
  final String text;
  void Function()? onTap;
  final bool isDawonload;
  void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DottedBorder(
        borderType: BorderType.RRect,
        strokeWidth: 2,
        radius: Radius.circular(12),
        child: Container(
          child: Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onTap,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(style: BorderStyle.solid),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: isDawonload
                            ? Icon(Icons.done_all, color: Colors.green)
                            : Image.asset("asset/add-photo.png"),
                      ),
                    ),
                    Text(text),
                  ],
                ),
              ),

              if (isDawonload)
                GestureDetector(
                  onTap: onPressed,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.cancel_outlined, color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
