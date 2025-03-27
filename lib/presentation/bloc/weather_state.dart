import 'package:equatable/equatable.dart';
import '../../domain/entities/weather.dart';

// Abstract base class for all weather states, extending Equatable for value comparison.
abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

// Initial state of the weather, typically before any action is taken.
class WeatherInitial extends WeatherState {}

// State representing that weather data is currently being loaded.
class WeatherLoading extends WeatherState {}

// State representing that weather data has been successfully loaded.
class WeatherLoaded extends WeatherState {
  final Weather weather; // The loaded weather data.

  const WeatherLoaded({required this.weather});

  @override
  List<Object> get props =>
      [weather]; // Include weather in equality comparison.
}

// State representing an error that occurred while fetching weather data.
class WeatherError extends WeatherState {
  final String message; // The error message.

  const WeatherError({required this.message});

  @override
  List<Object> get props =>
      [message]; // Include message in equality comparison.
}
