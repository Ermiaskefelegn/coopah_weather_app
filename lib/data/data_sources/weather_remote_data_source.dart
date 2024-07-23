import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
        'appid': dotenv.env['WEATHER_API_KEY'],
      },
    );
    return WeatherModel.fromJson(response.data);
  }
}
