import 'package:flutter/material.dart';

class catogriesOfMenue extends StatelessWidget {
  catogriesOfMenue({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });
  final String text;
  final Icon icon;
  Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Directionality(
          textDirection: TextDirection.rtl,

          child: GestureDetector(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                icon,
                Text(text, style: TextStyle(color: Colors.black)),
                Spacer(flex: 1),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Icon(Icons.arrow_back_ios_new),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
