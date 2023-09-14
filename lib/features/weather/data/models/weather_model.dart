import 'package:counter_weather_bloc/features/weather/domain/entities/weather.dart';

class WeatherModel extends Weather {
  const WeatherModel({
    required String name,
    required String country,
    required double currentTemp,
    required String condition,
    required int code,
  }) : super(
          name: name,
          country: country,
          currentTemp: currentTemp,
          condition: condition,
          code: code,
        );

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      currentTemp: json['current']['temp_c'],
      country: json['location']['country'],
      condition: json['current']['condition']['text'],
      code: json['current']['condition']['code'],
      name: json['location']['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temp_c': currentTemp,
      'country': country,
      'name': name,
      'text': condition
    };
  }
}
