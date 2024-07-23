import 'package:dio/dio.dart';
import '../models/weather_model.dart';

class WeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSource({required this.dio});

  Future<WeatherModel> fetchWeather(double lat, double lon) async {
    final response = await dio.get(
      'https://api.openweathermap.org/data/2.5/weather',
      queryParameters: {
        'lat': lat,
        'lon': lon,
        'appid': 'd39d56c77e53ff78e679b0861e2b1daa',
      },
    );
    return WeatherModel.fromJson(response.data);
  }
}
