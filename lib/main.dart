import 'package:counter_weather_bloc/features/counter/presentation/bloc/counter_bloc.dart';
import 'package:counter_weather_bloc/features/counter/presentation/screens/counter_screen.dart';
import 'package:counter_weather_bloc/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:counter_weather_bloc/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc()..add(InitialThemeEvent()),
        ),
        BlocProvider(
          create: (context) => CounterBloc(),
        ),
        BlocProvider(
          create: (context) => sl<WeatherBloc>(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: state.copyWith(
              useMaterial3: false,
              appBarTheme: AppBarTheme(
                backgroundColor:
                    state == ThemeData.light() ? Colors.blue : Colors.white10,
              ),
              backgroundColor:
                  state == ThemeData.light() ? Colors.white : Colors.black38,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: state == ThemeData.light()
                    ? Colors.blue
                    : Colors.greenAccent,
              ),
            ),
            home: const CounterScreen(),
          );
        },
      ),
    );
  }
}
