import 'package:car_serves/constant.dart';
import 'package:car_serves/cubits/SignIn_Regester/cubitGetStateOfWork.dart';
import 'package:car_serves/cubits/SignIn_Regester/stateGetStateOfWork.dart';
import 'package:car_serves/widget/StateOfWork.dart';
import 'package:car_serves/widget/bottomSheet/BottomSheet_StateNotWorking.dart';
import 'package:car_serves/widget/bottomSheet/bottomSheet_working.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SheetButtom extends StatefulWidget {
  SheetButtom({super.key});

  @override
  State<SheetButtom> createState() => _SheetButtomState();
}

class _SheetButtomState extends State<SheetButtom> {
  @override
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DraggableScrollableSheet(
      initialChildSize: 0.25,
      minChildSize: 0.15,
      maxChildSize: 0.25,
      builder: (context, scrollController) {
        return ListView(
          controller: scrollController,
          children: [
            DefaultTextStyle(
              style: TextStyle(color: Colors.white),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.245,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: colors),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.black,
                        blurStyle: BlurStyle.outer,
                      ),
                    ],
                  ),
                  child: BlocBuilder<Cubitgetstateofwork, Stategetstateofwork>(
                    builder: (context, state) {
                      if (state is StateSucssesgetstateOfWork) {
                        final stateOfWork = state.stateOfWork;
                        if (!stateOfWork) {
                          return BottomSheet_StateNotWorking(width: width);
                        } else {
                          return bottomSheet_working();
                        }
                      } else {
                        final String err = state is StatefaieldgetstateOfWork
                            ? state.err
                            : "err";
                        return Text(err);
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
