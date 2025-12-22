import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Customdropdowncityname extends StatelessWidget {
  Customdropdowncityname({
    required this.onSaved,
    required this.itemsCity,
    required this.lable,
    required this.widht,
    required this.hight,
    required this.validator,
  });
  void Function(String?)? onSaved;
  final String lable;
  final double widht;
  final double hight;
  String? Function(String?)? validator;
  List<DropdownMenuItem<String>>? itemsCity;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widht,
      height: hight,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        validator: (value) {},
        onChanged: onSaved,
        onSaved: onSaved,
        alignment: AlignmentGeometry.center,

        decoration: InputDecoration(
          label: Text(
            lable,
            textAlign: TextAlign.center,

            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
        items: itemsCity,
      ),
    );
  }
}
