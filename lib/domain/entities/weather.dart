import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final double temp;
  final String locationName;
  final String icon;
  const Weather(
      {required this.icon, required this.temp, required this.locationName});

  @override
  List<Object> get props => [temp, locationName];
}
