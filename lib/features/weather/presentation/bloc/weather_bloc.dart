import 'package:bloc/bloc.dart';
import 'package:counter_weather_bloc/core/error/failures.dart';
import 'package:counter_weather_bloc/core/usecases/usecase.dart';
import 'package:counter_weather_bloc/features/weather/domain/entities/weather.dart';
import 'package:counter_weather_bloc/features/weather/domain/usecases/get_weather.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeather getWeather;

  WeatherBloc({
    required GetWeather weather,
  })  : getWeather = weather,
        super(EmptyState()) {
    on<WeatherEvent>((event, emit) async {
      if (event is GetWeatherEvent) {
        emit(LoadingState());
        final failureOrWeather = await getWeather(NoParams());
        failureOrWeather.fold(
            (failure) => emit(Error(message: _mapFailureToMessage(failure))),
            (weather) => emit(LoadedState(weather: weather)));
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      default:
        return 'Unexpected error';
    }
  }
}
