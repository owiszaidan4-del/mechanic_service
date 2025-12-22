import 'package:car_serves/views/profileView.dart';
import 'package:car_serves/widget/ItemsOfGradeProfilePage.dart';
import 'package:car_serves/widget/MenueOfCenterView.dart';
import 'package:flutter/material.dart';

class Menue extends StatelessWidget {
  Menue({
    required this.onHorizontalDragUpdate,
    required this.items,
    required this.transform,
  });
  void Function(DragUpdateDetails)? onHorizontalDragUpdate;
  final List<ItemsOfGradeProfilePage> items;
  final Matrix4? transform;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      child: Align(
        alignment: Alignment.centerRight,
        child: AnimatedContainer(
          transform: transform,
          duration: Duration(milliseconds: 200),
          color: Colors.white.withOpacity(0.9),
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height,
          child: DefaultTextStyle(
            style: TextStyle(fontSize: 10, overflow: TextOverflow.ellipsis),
            child: MenueOfCenterView(items: items),
          ),
        ),
      ),
    );
  }
}
