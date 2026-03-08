import 'package:flutter/material.dart';

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
