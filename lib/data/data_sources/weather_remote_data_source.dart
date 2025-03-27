import 'package:coopah_weather_app/core/network/dio/dio_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/weather_model.dart';

// class WeatherRemoteDataSource {
//   final Dio dio;

//   WeatherRemoteDataSource({required this.dio});

//   Future<WeatherModel> fetchWeather(double lat, double lon) async {
//     try {
//       final response = await dio.get(
//         Constants.baseUrl,
//         queryParameters: {
//           'lat': lat,
//           'lon': lon,
//           'appid': dotenv.env['WEATHER_API_KEY'],
//         },
//       );
//       return WeatherModel.fromJson(response.data);
//     } on DioException catch (e) {
//       throw NetworkException.fromDioError(e);
//     } catch (e) {
//       throw Exception('Failed to load weather data');
//     }
//   }
// }

class WeatherRemoteDataSource {
  final DioClient dioClient;

  WeatherRemoteDataSource({required this.dioClient});

  Future<WeatherModel> fetchWeather(double lat, double lon) async {
    try {
      final response = await dioClient.get('weather', queryParameters: {
        'lat': lat,
        'lon': lon,
        'appid': dotenv.env['WEATHER_API_KEY'],
      });
      return response.data;
    } catch (e) {
      throw Exception('Failed to load weather data');
    }
  }
}
