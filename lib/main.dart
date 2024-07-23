import 'package:coopah_weather_app/data/data_sources/weather_remote_data_source.dart';
import 'package:coopah_weather_app/data/repositories/weather_repository_impl.dart';

import 'package:coopah_weather_app/presentation/pages/weather_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env"); // Load environment variables

  final dio = Dio();
  final remoteDataSource = WeatherRemoteDataSource(dio: dio);
  final repository = WeatherRepositoryImpl(remoteDataSource: remoteDataSource);
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final WeatherRepositoryImpl repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: WeatherPage(repository: repository),
    );
  }
}
