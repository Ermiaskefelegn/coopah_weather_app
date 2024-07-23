import 'package:bloc_test/bloc_test.dart';
import 'package:coopah_weather_app/domain/entities/weather.dart';
import 'package:coopah_weather_app/domain/usecases/get_weather.dart';
import 'package:coopah_weather_app/presentation/bloc/weather_bloc.dart';
import 'package:coopah_weather_app/presentation/bloc/weather_event.dart';
import 'package:coopah_weather_app/presentation/bloc/weather_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetWeather extends Mock implements GetWeather {}

void main() {
  late MockGetWeather mockGetWeather;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetWeather = MockGetWeather();
    weatherBloc = WeatherBloc(getWeather: mockGetWeather);
  });

  group('WeatherBloc', () {
    const lat = 51.51494225418024;
    const lon = -0.12363193061883422;

    const weather = Weather(
      temp: 280.0,
      locationName: 'London',
      icon: '01d',
    );

    test('initial state is WeatherInitial', () {
      expect(weatherBloc.state, WeatherInitial());
    });

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded] when FetchWeather is added and succeeds',
      build: () {
        when(() => mockGetWeather.call(lat, lon))
            .thenAnswer((_) async => weather);
        return weatherBloc;
      },
      act: (bloc) => bloc.add(FetchWeather(lat: lat, lon: lon)),
      expect: () => [
        WeatherLoading(),
        const WeatherLoaded(weather: weather),
      ],
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherError] when FetchWeather is added and fails',
      build: () {
        when(() => mockGetWeather.call(lat, lon))
            .thenThrow(Exception('Failed to fetch weather'));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(FetchWeather(lat: lat, lon: lon)),
      expect: () => [
        WeatherLoading(),
        const WeatherError(message: 'Exception: Failed to fetch weather'),
      ],
    );
  });
  tearDown(() {
    weatherBloc.close();
  });
}
