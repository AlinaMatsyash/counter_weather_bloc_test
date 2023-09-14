import 'package:counter_weather_bloc/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:counter_weather_bloc/features/weather/data/models/weather_model.dart';
import 'package:counter_weather_bloc/features/weather/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, WeatherModel>> getWeather() async {
    return await _getWeather(() {
      return remoteDataSource.getWeather();
    });
  }

  Future<Either<Failure, WeatherModel>> _getWeather(
    get,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await get();
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
