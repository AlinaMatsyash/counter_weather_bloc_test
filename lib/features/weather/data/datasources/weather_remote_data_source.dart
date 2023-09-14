import 'dart:convert';

import 'package:counter_weather_bloc/core/error/exceptions.dart';
import 'package:counter_weather_bloc/features/weather/data/models/weather_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getWeather();
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getWeather() async {
    String api = 'http://api.weatherapi.com/v1/forecast.json';
    String key = 'bc5c8117d9064d9ab25135502232301';
    Location location = Location();
    await location.getCurrentLocation();
    return _getWeatherFromUrl(
        '$api?key=$key&q=${location.latitude},${location.longitude}&days=7&aqi=no&alerts=no');
  }

  Future<WeatherModel> _getWeatherFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}

class Location {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
      print(latitude);
      print(longitude);
    } catch (e) {
      print(e);
    }
  }
}
