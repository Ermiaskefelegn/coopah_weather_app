import 'package:coopah_weather_app/core/constants/constants.dart';
import 'package:coopah_weather_app/core/di/dependency_Injection.dart';

import 'package:coopah_weather_app/presentation/pages/weather_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  // Ensures that Flutter bindings are initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // Sets up dependency injection for the app
  await setupInjector();
  await dotenv.load();

  final sentryDsn = dotenv.env[Constants.sentryDsn];

  if (kReleaseMode && sentryDsn?.isNotEmpty == true) {
    await SentryFlutter.init(
      (options) {
        options.dsn = sentryDsn;
        options.tracesSampleRate = 0.01;
      },
      appRunner: () => runApp(const WeatherAppMain()),
    );
  } else {
    // Runs the main application widget
    runApp(const WeatherAppMain());
  }
}

class WeatherAppMain extends StatelessWidget {
  const WeatherAppMain({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Defines the main structure of the app with MaterialApp
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner in the app
      title: 'Weather App', // Sets the title of the app
      home: WeatherPage(), // Sets the initial page of the app
    );
  }
}
