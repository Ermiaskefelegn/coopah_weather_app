import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../data_sources/weather_remote_data_source.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Weather> getWeather(double lat, double lon) async {
    final weatherModel = await remoteDataSource.fetchWeather(lat, lon);
    return Weather(
      icon: weatherModel.weather![0].icon ?? "04d",
      temp: weatherModel.main?.temp ?? 0.0,
      locationName: weatherModel.name ?? 'Unknown location',
    );
  }
}
