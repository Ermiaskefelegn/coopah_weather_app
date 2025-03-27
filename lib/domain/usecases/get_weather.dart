import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetWeather {
  final WeatherRepository repository;

  // Constructor to initialize the WeatherRepository dependency
  GetWeather(this.repository);

  // Method to fetch weather data based on latitude and longitude
  Future<Weather> call(double lat, double lon) async {
    return await repository.getWeather(lat, lon);
  }
}
