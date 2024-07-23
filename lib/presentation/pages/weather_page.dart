// lib/presentation/pages/weather_page.dart

import 'package:coopah_weather_app/data/repositories/weather_repository_impl.dart';
import 'package:coopah_weather_app/domain/repositories/weather_repository.dart';
import 'package:coopah_weather_app/domain/usecases/get_weather.dart';
import 'package:coopah_weather_app/presentation/widgets/custome_normal_button.dart';
import 'package:coopah_weather_app/presentation/widgets/lable_text.dart';
import 'package:coopah_weather_app/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  bool isFahrenheit = true;

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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) {
            final weatherRepository = GetIt.instance<WeatherRepository>();
            return WeatherBloc(getWeather: GetWeather(weatherRepository))
              ..add(FetchWeather(
                  lat: 51.51494225418024, lon: -0.12363193061883422));
          },
          child: Builder(
            builder: (context) {
              return BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  return _buildWeatherContent(context, state, height, width);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherContent(
      BuildContext context, WeatherState state, double height, double width) {
    if (state is WeatherInitial) {
      return const Center(child: Text('Please wait...'));
    } else if (state is WeatherLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is WeatherLoaded) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: width / 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWeatherIcon(state.weather.icon, height, width),
                _buildWeatherInfo(state, height, width),
                _buildUnitSwitch(),
              ],
            ),
            _refreshbutton(context, height, width)
          ],
        ),
      );
    } else if (state is WeatherError) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(state.message)));
      });
    }
    return Container();
  }

  Widget _buildWeatherIcon(String icon, double height, double width) {
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

  Widget _buildWeatherInfo(WeatherLoaded state, double height, double width) {
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

  Widget _buildUnitSwitch() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            "Degrees/Fahrenheit ",
            style: TextStyle(
              fontFamily: "Circular Std",
              fontWeight: FontWeight.normal,
              fontSize: 16,
              fontStyle: FontStyle.normal,
            ),
          ),
          Switch(
            value: isFahrenheit,
            activeColor: const Color(0xFFFF5700),
            onChanged: (bool value) {
              setState(() {
                isFahrenheit = value;
              });
            },
          )
        ],
      ),
    );
  }

  Widget _refreshbutton(BuildContext context, double height, double width) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: height / 30),
      child: CustomNormalButton(
        buttoncolor: const Color(0xFFFF5700),
        textcolor: Colors.white,
        text: "Refresh",
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
        onPressed: () {
          BlocProvider.of<WeatherBloc>(context).add(
            FetchWeather(
              lat: 51.51494225418024,
              lon: -0.12363193061883422,
            ),
          );
        },
      ),
    );
  }
}
