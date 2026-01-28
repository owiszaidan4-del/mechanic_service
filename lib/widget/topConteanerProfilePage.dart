import 'dart:developer';

import 'package:car_serves/constant.dart';
import 'package:car_serves/cubits/SignIn_Regester/cubitGetAll__infoUsers.dart';
import 'package:car_serves/cubits/SignIn_Regester/stateGetAll_infoUsers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class topConteanerProfilePage extends StatelessWidget {
  const topConteanerProfilePage({super.key, required this.pop});
  final bool pop;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.solid,
              offset: Offset(1, 1),
              blurRadius: BorderSide.strokeAlignCenter,
            ),
          ],
          gradient: LinearGradient(colors: colors),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8,

            children: [
              if (pop)
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.centerRight,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(Icons.arrow_back_ios),
                      ),
                    ),
                  ),
                ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Expanded(
                  child:
                      BlocBuilder<cubitGetAll__infoUsers, StategetallInfousers>(
                        builder: (context, state) {
                          if (state is StateSucsess) {
                            log(state.allInfoUsers.userId);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state.allInfoUsers.fullName,
                                  style: TextStyle(color: Colors.white),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.blueAccent,
                                      size: 20,
                                    ),
                                    Text(
                                      "${state.allInfoUsers.performance} ",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white.withOpacity(0.4),
                                      ),
                                    ),
                                    Text(
                                      state.allInfoUsers.userId,
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          } else if (state is StateLoad) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state is StateFaield) {
                            log(state.errType);

                            throw Exception(state.errType);
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                ),
              ),
              CircleAvatar(radius: 30, child: Icon(Icons.person_2_rounded)),
            ],
          ),
        ),
      ),
    );
  }
}
