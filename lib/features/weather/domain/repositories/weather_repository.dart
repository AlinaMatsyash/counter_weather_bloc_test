import 'package:counter_weather_bloc/features/weather/data/models/weather_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherModel>> getWeather();
}
