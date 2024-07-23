import 'package:coopah_weather_app/data/data_sources/weather_remote_data_source.dart';
import 'package:coopah_weather_app/domain/repositories/weather_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

// Your app's classes
import 'package:coopah_weather_app/data/repositories/weather_repository_impl.dart';
import 'package:coopah_weather_app/domain/usecases/get_weather.dart';
import 'package:coopah_weather_app/presentation/bloc/weather_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupInjector() async {
  await dotenv.load(fileName: ".env"); // Load environment variables

  // Dio
  getIt.registerLazySingleton(() => Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 5),
      )));

  // Data Source
  getIt.registerLazySingleton(() => WeatherRemoteDataSource(dio: getIt()));

  // Repository
  getIt.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(remoteDataSource: getIt()));

  // Use Case
  getIt.registerLazySingleton(() => GetWeather(getIt()));

  // Bloc
  getIt.registerFactory(() => WeatherBloc(getWeather: getIt()));
}
