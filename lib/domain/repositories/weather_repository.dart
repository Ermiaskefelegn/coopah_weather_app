import '../entities/weather.dart';

/// An abstract class that defines the contract for a weather repository.
///
/// This repository is responsible for fetching weather data based on
/// geographical coordinates (latitude and longitude).
abstract class WeatherRepository {
  /// Fetches the weather information for the specified latitude and longitude.
  ///
  /// [lat] - The latitude of the location.
  /// [lon] - The longitude of the location.
  ///
  /// Returns a [Future] that resolves to a [Weather] object containing
  /// the weather details for the specified location.
  Future<Weather> getWeather(double lat, double lon);
}
