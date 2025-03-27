import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final double temp; // The temperature value
  final String locationName; // The name of the location
  final String icon; // The icon representing the weather condition

  const Weather(
      {required this.icon, required this.temp, required this.locationName});

  @override
  List<Object> get props =>
      [temp, locationName]; // Properties used for equality comparison
}
