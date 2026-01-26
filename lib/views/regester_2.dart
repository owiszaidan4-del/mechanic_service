import 'package:car_serves/cubits/SignIn_Regester/States_RegesterAuthTransaction.dart';
import 'package:car_serves/cubits/SignIn_Regester/cubit_RegesterAuthTransaction.dart';
import 'package:car_serves/widget/CustomDropDownCityName.dart';
import 'package:car_serves/widget/NameApp.dart';
import 'package:car_serves/widget/button_signIn.dart';
import 'package:car_serves/widget/customTextFeild.dart';
import 'package:car_serves/widget/logoApp.dart';
import 'package:car_serves/widget/statment_open.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Regester2 extends StatefulWidget {
  Regester2({
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.confirmPassword,
    required this.fullName,
  });
  final String email;
  final String password;
  final String phoneNumber;
  final String confirmPassword;
  final String fullName;
  @override
  State<Regester2> createState() => _Regester2State();
}

class _Regester2State extends State<Regester2> {
  String? workShopName;

  String? workadress;

  String? city;
  String? area;
  //

  //
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? specialization;
  List<DropdownMenuItem<String>> itemsCity = const [
    DropdownMenuItem(
      value: "Amman",

      alignment: AlignmentGeometry.center,
      child: Text("عمان", style: TextStyle(fontSize: 8)),
    ),
    DropdownMenuItem(
      value: "Alzarqa",
      alignment: AlignmentGeometry.center,
      child: Text("الزرقاء", style: TextStyle(fontSize: 8)),
    ),
    DropdownMenuItem(
      value: "Irbid",
      alignment: AlignmentGeometry.center,
      child: Text("اربد", style: TextStyle(fontSize: 8)),
    ),
    DropdownMenuItem(
      value: "Madba",
      alignment: AlignmentGeometry.center,
      child: Text("مأدبا", style: TextStyle(fontSize: 8)),
    ),
  ];
  List<DropdownMenuItem<String>> itemsArea = const [
    DropdownMenuItem(
      value: "8",

      alignment: AlignmentGeometry.center,
      child: Text("8km", style: TextStyle(fontSize: 8)),
    ),
    DropdownMenuItem(
      value: "16",
      alignment: AlignmentGeometry.center,
      child: Text("16km", style: TextStyle(fontSize: 8)),
    ),
    DropdownMenuItem(
      value: "32",
      alignment: AlignmentGeometry.center,
      child: Text("32km", style: TextStyle(fontSize: 8)),
    ),
    DropdownMenuItem(
      value: "10",
      alignment: AlignmentGeometry.center,
      child: Text("الافتراضي", style: TextStyle(fontSize: 8)),
    ),
  ];

  List<DropdownMenuItem<String>> itemsspecialization = const [
    DropdownMenuItem(
      value: "enging",

      alignment: AlignmentGeometry.center,
      child: Text("المحركات", style: TextStyle(fontSize: 8)),
    ),
    DropdownMenuItem(
      value: "electrecal",
      alignment: AlignmentGeometry.center,
      child: Text("كهربائي سيارات", style: TextStyle(fontSize: 8)),
    ),
    DropdownMenuItem(
      value: "tires",
      alignment: AlignmentGeometry.center,
      child: Text("اطارات", style: TextStyle(fontSize: 8)),
    ),
    DropdownMenuItem(
      value: "general",
      alignment: AlignmentGeometry.center,
      child: Text("عام", style: TextStyle(fontSize: 8)),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: NameApp(size: MediaQuery.of(context).size.width * 0.05),
      ),
      body: Center(
        child: Form(
          autovalidateMode: autovalidateMode,
          key: globalKey,
          child: SingleChildScrollView(
            child:
                BlocListener<
                  CubitRegesterauthtransaction,
                  StatesRegesterauthtransaction
                >(
                  listener: (context, state) {
                    if (state is state_success) {
                      Navigator.pushNamed(context, "HomeView");
                    } else if (state is state_failed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.typeFailed),
                          duration: Duration(seconds: 10),
                        ),
                      );

                      Navigator.pop(context);
                    }
                  },

                  child: Column(
                    spacing: 10,

                    children: [
                      logoApp(),

                      customTextFeild(
                        inputFormatters: filtterFullNameText,
                        hint: "اسم ورشة العمل",
                        icon: Icon(Icons.work),
                        onSaved: (val) {
                          workShopName = val;
                        },
                        validator: fullNameValidat,
                      ),
                      customTextFeild(
                        inputFormatters: filtterFullNameText,
                        hint: "مكان ورشة العمل",
                        icon: Icon(Icons.home_work),
                        onSaved: (val) {
                          workadress = val;
                        },
                        validator: fullNameValidat,
                      ),
                      Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Customdropdowncityname(
                            validator: dropdownValidat,
                            widht: MediaQuery.of(context).size.width * 0.4,
                            hight: MediaQuery.of(context).size.height * 0.09,
                            lable: "من اي مدينة؟",
                            onSaved: (value) {
                              city = value;
                            },

                            itemsCity: itemsCity,
                          ),
                          Customdropdowncityname(
                            validator: dropdownValidat,
                            widht: MediaQuery.of(context).size.width * 0.4,
                            hight: MediaQuery.of(context).size.height * 0.09,
                            lable: "الحد الاعلى للمسافة km",
                            onSaved: (value) {
                              area = value;
                            },
                            itemsCity: itemsArea,
                          ),
                        ],
                      ),
                      Customdropdowncityname(
                        validator: dropdownValidat,
                        widht: MediaQuery.of(context).size.width * 0.8,
                        hight: MediaQuery.of(context).size.height * 0.09,
                        lable: "...مختص في",
                        onSaved: (value) {
                          specialization = value;
                        },
                        itemsCity: itemsspecialization,
                      ),
                      button_signIn(
                        text: "انشاء الحساب",
                        onTap: () {
                          if (globalKey.currentState!.validate()) {
                            globalKey.currentState!.save();
                            BlocProvider.of<CubitRegesterauthtransaction>(
                              context,
                            ).sendRegesterInfo(
                              email: widget.email,
                              password: widget.password,
                              phoneNumber: widget.phoneNumber,
                              confirmPassword: widget.confirmPassword,
                              fullName: widget.fullName,
                              workShopName: workShopName,
                              workadress: workadress,
                              city: city,
                              area: area,
                              specialization: specialization,
                            );
                          } else {
                            setState(() {
                              autovalidateMode = AutovalidateMode.always;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
          ),
        ),
      ),
    );
  }
}

String? dropdownValidat(val) {
  if (val != null) {
    return null;
  } else {
    return "هذا الحقل مطلوب";
  }
}

String? fullNameValidat(value) {
  if (value?.isEmpty ?? true) {
    return "هذا الحقل مطلوب";
  } else {
    return null;
  }
}

List<TextInputFormatter> get filtterFullNameText {
  return [
    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),

    LengthLimitingTextInputFormatter(60),
  ];
}
