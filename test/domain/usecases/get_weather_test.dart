import 'package:coopah_weather_app/data/repositories/weather_repository_impl.dart';
import 'package:coopah_weather_app/domain/entities/weather.dart';
import 'package:coopah_weather_app/domain/usecases/get_weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherRepository extends Mock implements WeatherRepositoryImpl {}

void main() {
  late MockWeatherRepository mockWeatherRepository;
  late GetWeather getWeather;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getWeather = GetWeather(mockWeatherRepository);
  });

  const lat = 51.51494225418024;
  const lon = -0.12363193061883422;

  const weather = Weather(
    temp: 280.0,
    locationName: 'London',
    icon: '01d',
  );

  test('should get weather data from the repository', () async {
    when(() => mockWeatherRepository.getWeather(lat, lon))
        .thenAnswer((_) async => weather);

    final result = await getWeather.call(lat, lon);

    expect(result, weather);
    verify(() => mockWeatherRepository.getWeather(lat, lon)).called(1);
  });

  test('should throw an exception when repository fails', () async {
    when(() => mockWeatherRepository.getWeather(lat, lon))
        .thenThrow(Exception('Failed to fetch weather'));

    expect(() => getWeather.call(lat, lon), throwsException);
    verify(() => mockWeatherRepository.getWeather(lat, lon)).called(1);
  });
}
