import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../data_sources/weather_remote_data_source.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  // Constructor to initialize the remote data source dependency
  WeatherRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Weather> getWeather(double lat, double lon) async {
    // Fetch weather data from the remote data source
    final weatherModel = await remoteDataSource.fetchWeather(lat, lon);

    // Map the fetched data to the Weather entity and return it
    return Weather(
      icon: weatherModel.weather![0].icon ?? "04d", // Default icon if null
      temp: weatherModel.main?.temp ?? 0.0, // Default temperature if null
      locationName: weatherModel.name ??
          'Unknown location', // Default location name if null
    );
  }
}
