import 'package:coopah_weather_app/presentation/bloc/weather_state.dart';
import 'package:coopah_weather_app/presentation/widgets/lable_text.dart';
import 'package:flutter/material.dart';

class WeatherInfoWidget extends StatelessWidget {
  final WeatherLoaded state;
  final double height;
  final double width;
  final bool isFahrenheit;

  const WeatherInfoWidget({
    super.key,
    required this.state,
    required this.height,
    required this.width,
    required this.isFahrenheit,
  });

  String formatTemperature(double tempInKelvin, bool isFahrenheit) {
    if (isFahrenheit) {
      // Convert Kelvin to Fahrenheit
      double tempInFahrenheit = (tempInKelvin - 273.15) * 9 / 5 + 32;
      return '${tempInFahrenheit.toStringAsFixed(1)} °F';
    } else {
      // Convert Kelvin to Celsius
      double tempInCelsius = tempInKelvin - 273.15;
      return '${tempInCelsius.toStringAsFixed(1)} °C';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: height / 45),
          width: width,
          alignment: Alignment.center,
          child: const Text(
            'THIS IS MY WEATHER APP',
            style: TextStyle(
              fontFamily: "Futura Condensed PT",
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        SizedBox(
          height: height / 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const LabeledText(
                label: 'Temperature',
                weight: FontWeight.w700,
                fontsize: 17,
              ),
              LabeledText(
                label:
                    '${formatTemperature(state.weather.temp, isFahrenheit)} ${isFahrenheit ? 'Fahrenheit' : 'Degrees'}',
                weight: FontWeight.normal,
                fontsize: 16,
              ),
              const LabeledText(
                label: 'Location',
                weight: FontWeight.w700,
                fontsize: 17,
              ),
              LabeledText(
                label: state.weather.locationName,
                weight: FontWeight.normal,
                fontsize: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
