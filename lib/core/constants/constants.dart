class Constants {
  // Base URL for the OpenWeatherMap API
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/';

  // Base URL for fetching weather icons from OpenWeatherMap
  static const String weatherIconbaseUrl = 'https://openweathermap.org/img/wn/';

  // Default latitude and longitude for weather data (e.g., London coordinates)
  static const double lat = 51.51494225418024;
  static const double lon = -0.12363193061883422;

  // Sentry DSN for error tracking and monitoring
  static const String sentryDsn = 'SENTRY_DSN';

  // API key for accessing OpenWeatherMap services
  static const String weatherApiKey = 'WEATHER_API_KEY';
}
