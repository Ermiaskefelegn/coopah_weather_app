import 'package:coopah_weather_app/core/constants/constants.dart';
import 'package:flutter/material.dart';

// A stateless widget to display a weather icon with dynamic sizing and styling.
class WeatherIcon extends StatelessWidget {
  const WeatherIcon({
    super.key,
    required this.icon,
    required this.height,
    required this.width,
  });

  final String icon; // The icon name to be displayed.
  final double height; // The height of the parent container.
  final double width; // The width of the parent container.

  @override
  Widget build(BuildContext context) {
    double adjustedHeight;
    if (width < 300) {
      // Adjust height for small widths using a 4:3 aspect ratio.
      adjustedHeight = width * 3 / 4;
    } else {
      // Adjust height for larger widths using a 16:9 aspect ratio.
      adjustedHeight = width * 9 / 16;
    }

    return Container(
      margin:
          EdgeInsets.symmetric(vertical: height / 40), // Add vertical margin.
      decoration: BoxDecoration(
        color: const Color.fromARGB(
            255, 225, 224, 224), // Light gray background color.
        borderRadius: BorderRadius.circular(20), // Rounded corners.
      ),
      child: Center(
        child: Image.network(
          "${Constants.weatherIconbaseUrl}$icon.png", // Fetch the weather icon from the URL.
          height: adjustedHeight, // Adjusted height for the icon.
          filterQuality: FilterQuality.high, // High-quality image rendering.
          width: width / 2.5, // Set the width of the icon.
          fit: BoxFit.contain, // Ensure the icon fits within the bounds.
        ),
      ),
    );
  }
}
