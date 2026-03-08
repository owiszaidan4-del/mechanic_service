import 'dart:io';

import 'package:flutter/material.dart';

class circleImage extends StatelessWidget {
  const circleImage({
    super.key,
    required this.newimagePath,
    required this.circularProgress,
    required this.urlImage,
  });
  final String urlImage;
  final String? newimagePath;
  final Widget? circularProgress;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: newimagePath != null
          ? FileImage(File(newimagePath!))
          : NetworkImage(urlImage),
      child: circularProgress,
    );
  }
}
