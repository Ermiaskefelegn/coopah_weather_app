import 'package:coopah_weather_app/core/network_exception_hundler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'weather_event.dart';
import 'weather_state.dart';
import '../../domain/usecases/get_weather.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeather getWeather;

  WeatherBloc({required this.getWeather}) : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather = await getWeather(event.lat, event.lon);
        emit(WeatherLoaded(weather: weather));
      } on NetworkException catch (e) {
        emit(WeatherError(message: e.message));
      } catch (e) {
        emit(WeatherError(message: e.toString()));
      }
    });
  }
}
