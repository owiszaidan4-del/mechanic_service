import 'package:flutter/material.dart';

class personalInfo_of_sheet_new_order extends StatelessWidget {
  final String urlImage;
  final String name;
  final String carModel;
  const personalInfo_of_sheet_new_order({
    super.key,
    required this.urlImage,
    required this.name,
    required this.carModel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        CircleAvatar(
          radius: 25,
          child: Image.network(urlImage, fit: BoxFit.cover),
        ),
        Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                name,
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
                carModel,
                style: TextStyle(fontSize: 10, overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
