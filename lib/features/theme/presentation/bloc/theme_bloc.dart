import 'package:bloc/bloc.dart';
import 'package:counter_weather_bloc/features/counter/presentation/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  ThemeBloc() : super(ThemeData.light()) {
    on<InitialThemeEvent>((event, emit) async {
      final bool hasDarkTheme = await isDark();
      if (hasDarkTheme) {
        emit(ThemeData.dark());
      } else {
        emit(ThemeData.light());
      }
    });

    on<ThemeChangeEvent>((event, emit) {
      final isDark = state == ThemeData.dark();
      emit(isDark ? ThemeData.light() : ThemeData.dark());
      setTheme(isDark);
    });
  }
}
