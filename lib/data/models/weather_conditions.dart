import 'package:json_annotation/json_annotation.dart';

part 'weather_conditions.g.dart';

@JsonSerializable()
class WeatherConditions {
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? humidity;
  final int? seaLevel;
  final int? grndLevel;

  WeatherConditions({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  factory WeatherConditions.fromJson(Map<String, dynamic> json) =>
      _$WeatherConditionsFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherConditionsToJson(this);
}
