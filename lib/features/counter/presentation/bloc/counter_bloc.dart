import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_event.dart';

part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<Increment>((event, emit) async {
      final bool hasDarkTheme = await isDark();
      if (state < 10) {
        hasDarkTheme && state != 9 ? emit(state + 2) : emit(state + 1);
      }
    });
    on<Decrement>((event, emit) async {
      final bool hasDarkTheme = await isDark();
      if (state > 0) {
        hasDarkTheme && state != 1 ? emit(state - 2) : emit(state - 1);
      }
    });
  }
}

Future<bool> isDark() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("dark") ?? false;
}

Future<void> setTheme(bool isDark) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("dark", !isDark);
}
