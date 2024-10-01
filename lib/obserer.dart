// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';


class Observer implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print('Change: $change');
  }

  @override
  void onClose(BlocBase bloc) {
    print('Close: $bloc');
  }

  @override
  void onCreate(BlocBase bloc) {
    print('Create: $bloc');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('Error: $error');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    print('Event: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('Transition: $transition');
  }
}
