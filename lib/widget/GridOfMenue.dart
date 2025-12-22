import 'package:car_serves/views/profileView.dart';
import 'package:car_serves/widget/ItemsOfGradeProfilePage.dart';
import 'package:flutter/material.dart';

class GridOfMenue extends StatelessWidget {
  const GridOfMenue({super.key, required this.items});

  final List<ItemsOfGradeProfilePage> items;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
      ),
      itemBuilder: (context, index) {
        return items[index];
      },
      itemCount: items.length,
    );
  }
}
