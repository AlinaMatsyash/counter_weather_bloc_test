part of 'weather_bloc.dart';

@immutable
abstract class WeatherState extends Equatable {
  @override
  List<Object> get props => [];
}

class EmptyState extends WeatherState {}

class LoadingState extends WeatherState {}

class LoadedState extends WeatherState {
  final Weather weather;

  LoadedState({required this.weather});

  @override
  List<Object> get props => [weather];
}

class Error extends WeatherState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
