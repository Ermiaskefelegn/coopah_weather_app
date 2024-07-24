import 'package:coopah_weather_app/core/constants.dart';
import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({
    super.key,
    required this.icon,
    required this.height,
    required this.width,
  });

  final String icon;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    double adjustedHeight;
    if (width < 300) {
      // For width under 300px, use a 4:3 aspect ratio
      adjustedHeight = width * 3 / 4;
    } else {
      // For width 300px and above, use a 16:9 aspect ratio
      adjustedHeight = width * 9 / 16;
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: height / 40),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 225, 224, 224),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Image.network(
          "${Constants.weatherIconbaseUrl}$icon.png",
          height: adjustedHeight,
          filterQuality: FilterQuality.high,
          width: width / 2.5,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
