import 'package:equatable/equatable.dart';

// Abstract base class for all weather-related events.
// Extends Equatable to enable value comparison.
abstract class WeatherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Event to fetch weather data based on latitude and longitude.
class FetchWeather extends WeatherEvent {
  final double lat; // Latitude of the location.
  final double lon; // Longitude of the location.

  // Constructor to initialize latitude and longitude.
  FetchWeather({required this.lat, required this.lon});

  @override
  List<Object> get props => [lat, lon]; // Properties for value comparison.
}
