import 'package:coopah_weather_app/core/dependency_Injection.dart';

import 'package:coopah_weather_app/presentation/pages/weather_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjector();

  runApp(const WeatherAppMain());
}

class WeatherAppMain extends StatelessWidget {
  const WeatherAppMain({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      home: WeatherPage(),
    );
  }
}
