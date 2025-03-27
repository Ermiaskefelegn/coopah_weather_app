import 'package:coopah_weather_app/data/models/weather_conditions.dart';
import 'package:coopah_weather_app/data/models/weather_details.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

/// A model representing weather data, annotated for JSON serialization.
@JsonSerializable()
class WeatherModel {
  final Coord? coord; // Coordinates of the location.
  final List<Weather>? weather; // Weather conditions (e.g., description, icon).
  final String? base; // Internal parameter, not typically used.
  final WeatherConditions?
      main; // Main weather details (e.g., temperature, pressure).
  final int? visibility; // Visibility in meters.
  final Wind? wind; // Wind details (e.g., speed, direction).
  final Clouds? clouds; // Cloudiness percentage.
  final int? dt; // Time of data calculation (Unix timestamp).
  final Sys? sys; // Additional system data (e.g., country, sunrise/sunset).
  final int? timezone; // Timezone offset in seconds.
  final int? id; // City ID.
  final String? name; // City name.
  final int? cod; // HTTP status code of the response.

  WeatherModel({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  /// Factory constructor to create a WeatherModel from a JSON map.
  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  /// Converts the WeatherModel instance to a JSON map.
  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}
