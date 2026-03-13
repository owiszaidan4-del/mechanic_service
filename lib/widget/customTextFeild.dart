import 'package:car_serves/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class customTextFeild extends StatelessWidget {
  customTextFeild({
    super.key,
    this.err,
    this.textDescreption,
    required this.hint,
    required this.icon,
    required this.onSaved,
    required this.validator,
    required this.inputFormatters,
  });
  void Function(String?)? onSaved;
  String? Function(String?)? validator;
  List<TextInputFormatter>? inputFormatters;
  final String hint;
  final Icon icon;
  final String? err;
  final String? textDescreption;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        forceErrorText: err,
        inputFormatters: inputFormatters,
        onSaved: onSaved,
        validator: validator,
        decoration: InputDecoration(
          helper: textDescreption != null
              ? Center(
                  child: Text(
                    textDescreption!,
                    style: TextStyle(color: Colors.black.withOpacity(0.3)),
                  ),
                )
              : null,
          fillColor: Colors.white,
          prefixIcon: icon,
          hint: Text(hint, style: TextStyle(color: hintColor)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.01,
          ),
        ),
      ),
    );
  }
}
