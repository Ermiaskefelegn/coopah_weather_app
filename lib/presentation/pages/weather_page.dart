import 'package:coopah_weather_app/core/constants.dart';
import 'package:coopah_weather_app/domain/repositories/weather_repository.dart';
import 'package:coopah_weather_app/domain/usecases/get_weather.dart';
import 'package:coopah_weather_app/presentation/widgets/custome_normal_button.dart';
import 'package:coopah_weather_app/presentation/widgets/weather_detail.dart';
import 'package:coopah_weather_app/presentation/widgets/weather_icon.dart';
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
              ..add(FetchWeather(lat: Constants.lat, lon: Constants.lon));
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
                WeatherIcon(
                    icon: state.weather.icon, height: height, width: width),
                WeatherInfoWidget(
                    state: state,
                    height: height,
                    width: width,
                    isFahrenheit: isFahrenheit),
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
              lat: Constants.lat,
              lon: Constants.lon,
            ),
          );
        },
      ),
    );
  }
}
