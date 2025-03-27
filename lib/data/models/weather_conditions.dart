import 'package:json_annotation/json_annotation.dart';

part 'weather_conditions.g.dart';

/// A model class representing weather conditions with various attributes.
/// This class is annotated with `@JsonSerializable` to enable JSON serialization.
@JsonSerializable()

/// A class representing weather conditions with various attributes.
class WeatherConditions {
  final double? temp; // Current temperature
  final double? feelsLike; // Perceived temperature
  final double? tempMin; // Minimum temperature
  final double? tempMax; // Maximum temperature
  final int? pressure; // Atmospheric pressure
  final int? humidity; // Humidity percentage
  final int? seaLevel; // Atmospheric pressure at sea level
  final int? grndLevel; // Atmospheric pressure at ground level

  /// Constructor for initializing weather condition attributes.
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

  /// Factory constructor to create an instance of `WeatherConditions` from a JSON map.
  factory WeatherConditions.fromJson(Map<String, dynamic> json) =>
      _$WeatherConditionsFromJson(json);

  /// Converts an instance of `WeatherConditions` to a JSON map.
  Map<String, dynamic> toJson() => _$WeatherConditionsToJson(this);
}
