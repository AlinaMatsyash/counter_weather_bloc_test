import 'package:counter_weather_bloc/features/weather/data/models/weather_model.dart';
import 'package:counter_weather_bloc/features/weather/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetWeather implements UseCase<WeatherModel, NoParams> {
  final WeatherRepository repository;

  GetWeather(this.repository);

  @override
  Future<Either<Failure, WeatherModel>> call(NoParams params) async {
    return await repository.getWeather();
  }
}
