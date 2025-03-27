import 'package:coopah_weather_app/core/network/dio/network_exception_hundler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'weather_event.dart';
import 'weather_state.dart';
import '../../domain/usecases/get_weather.dart';

// Bloc class for managing weather-related states and events
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeather getWeather;

  WeatherBloc({required this.getWeather}) : super(WeatherInitial()) {
    // Event handler for FetchWeather event
    on<FetchWeather>((event, emit) async {
      // Emit loading state while fetching weather data
      emit(WeatherLoading());
      try {
        // Fetch weather data using the provided latitude and longitude
        final weather = await getWeather(event.lat, event.lon);
        // Emit loaded state with the fetched weather data
        emit(WeatherLoaded(weather: weather));
      } on NetworkException catch (e) {
        // Handle network-related exceptions and emit error state with a message
        emit(WeatherError(message: e.message));
      } catch (e) {
        // Handle any other exceptions and emit error state with the exception message
        emit(WeatherError(message: e.toString()));
      }
    });
  }
}
