import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String name;
  final String country;
  final double currentTemp;
  final String condition;
  final int code;

  const Weather({
    required this.name,
    required this.country,
    required this.currentTemp,
    required this.condition,
    required this.code,
  });

  @override
  List<Object> get props => [
        name,
        country,
        currentTemp,
        condition,
        code,
      ];
}
