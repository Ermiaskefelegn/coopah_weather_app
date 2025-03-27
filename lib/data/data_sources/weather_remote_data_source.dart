import 'package:coopah_weather_app/core/constants/constants.dart';
import 'package:coopah_weather_app/core/network/dio/dio_client.dart';
import 'package:coopah_weather_app/core/network/dio/network_exception_hundler.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/weather_model.dart';

class WeatherRemoteDataSource {
  final DioClient dioClient;

  // Constructor to initialize the DioClient dependency
  WeatherRemoteDataSource({required this.dioClient});

  // Fetches weather data from the remote API using latitude and longitude
  Future<WeatherModel> fetchWeather(double lat, double lon) async {
    try {
      // Makes a GET request to the 'weather' endpoint with query parameters
      final response = await dioClient.get('weather', queryParameters: {
        'lat': lat,
        'lon': lon,
        'appid': dotenv
            .env[Constants.weatherApiKey], // API key from environment variables
      });
      // Parses the response data into a WeatherModel object
      return WeatherModel.fromJson(response.data);
    } on DioException catch (e) {
      // Handles Dio-specific exceptions and converts them to a NetworkException
      throw NetworkException.fromDioError(e);
    } catch (e) {
      // Handles any other exceptions
      throw Exception('Failed to load weather data');
    }
  }
}
