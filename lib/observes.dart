import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class Observes1 implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint("$bloc====$change");
  }

  @override
  void onClose(BlocBase bloc) {
    debugPrint("closebloc::::$bloc");
  }

  @override
  void onCreate(BlocBase bloc) {
    debugPrint("created::::::$bloc");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // TODO: implement onError
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    // TODO: implement onEvent
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
  }

  @override
  void onDone(
    Bloc bloc,
    Object? event, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    // TODO: implement onDone
  }
}
