import 'package:flutter/material.dart';

class ItemsOfGradeProfilePage extends StatelessWidget {
  ItemsOfGradeProfilePage({
    super.key,
    required this.image,
    required this.onTap,
    required this.desc,
  });
  final ImageProvider<Object> image;
  void Function()? onTap;
  final String desc;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                color: Colors.black.withOpacity(0.2),
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image(image: image, width: 23, height: 23),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    desc,
                    style: TextStyle(color: Colors.black, fontSize: 8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
