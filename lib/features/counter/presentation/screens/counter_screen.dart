import 'package:counter_weather_bloc/features/counter/presentation/bloc/counter_bloc.dart';
import 'package:counter_weather_bloc/features/counter/presentation/widgets/counter_decrement.dart';
import 'package:counter_weather_bloc/features/counter/presentation/widgets/counter_increment.dart';
import 'package:counter_weather_bloc/features/theme/presentation/widgets/change_theme.dart';
import 'package:counter_weather_bloc/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:counter_weather_bloc/features/weather/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  void initState() {
    _handleLocationPermission();
    super.initState();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Counter'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is EmptyState) {
                  return const Text('Press the icon to get your location');
                }
                if (state is LoadingState) {
                  return const LoadingWidget();
                }
                if (state is LoadedState) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Center(
                      child: Text(
                          'Weather for ${state.weather.name}, ${state.weather.country}: ${state.weather.currentTemp}°C (${state.weather.currentTemp * 1.8 + 32}°F)'),
                    ),
                  );
                }
                return const Text('');
              },
            ),
            const SizedBox(height: 40),
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CounterBloc, int>(
              builder: (context, count) {
                return Text(
                  '$count',
                  style: const TextStyle(fontSize: 30),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      context.read<WeatherBloc>().add(GetWeatherEvent());
                    },
                    child: const Icon(Icons.cloud),
                  ),
                  const CounterIncrement(),
                ],
              ),
              const SizedBox(height: 30),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChangeTheme(),
                  CounterDecrement(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
