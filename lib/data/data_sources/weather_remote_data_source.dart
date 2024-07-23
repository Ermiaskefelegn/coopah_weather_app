import 'package:coopah_weather_app/core/constants.dart';
import 'package:coopah_weather_app/core/network_exception_hundler.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/weather_model.dart';

class WeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSource({required this.dio});

  Future<WeatherModel> fetchWeather(double lat, double lon) async {
    try {
      final response = await dio.get(
        Constants.baseUrl,
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': dotenv.env['WEATHER_API_KEY'],
        },
      );
      return WeatherModel.fromJson(response.data);
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    } catch (e) {
      throw Exception('Failed to load weather data');
    }
  }
}
