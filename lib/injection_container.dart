import 'package:counter_weather_bloc/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:counter_weather_bloc/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:counter_weather_bloc/features/weather/domain/repositories/weather_repository.dart';
import 'package:counter_weather_bloc/features/weather/domain/usecases/get_weather.dart';
import 'package:counter_weather_bloc/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => WeatherBloc(
      weather: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetWeather(sl()));

  // Repository
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(client: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
