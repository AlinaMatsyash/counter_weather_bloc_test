import 'package:counter_weather_bloc/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeTheme extends StatelessWidget {
  const ChangeTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeData>(
      builder: (context, themeData) {
        return FloatingActionButton(
          onPressed: () {
            BlocProvider.of<ThemeBloc>(context).add(ThemeChangeEvent());
          },
          child: const Icon(Icons.color_lens),
        );
      },
    );
  }
}
