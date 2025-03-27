import 'package:coopah_weather_app/core/constants/constants.dart';
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

// WeatherPage is the main page widget for displaying weather information.
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // Boolean to track the temperature unit (Fahrenheit or Celsius).
  bool isFahrenheit = true;

  @override
  Widget build(BuildContext context) {
    // Get the screen dimensions for responsive UI.
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        // Provide the WeatherBloc to the widget tree.
        child: BlocProvider(
          create: (context) {
            // Retrieve the WeatherRepository instance using GetIt.
            final weatherRepository = GetIt.instance<WeatherRepository>();
            // Initialize the WeatherBloc and fetch weather data.
            return WeatherBloc(getWeather: GetWeather(weatherRepository))
              ..add(FetchWeather(lat: Constants.lat, lon: Constants.lon));
          },
          child: Builder(
            builder: (context) {
              // Listen to WeatherBloc state changes and rebuild UI accordingly.
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

  // Builds the main content of the weather page based on the current state.
  Widget _buildWeatherContent(
      BuildContext context, WeatherState state, double height, double width) {
    if (state is WeatherInitial) {
      // Initial state: show a loading message.
      return const Center(child: Text('Please wait...'));
    } else if (state is WeatherLoading) {
      // Loading state: show a progress indicator.
      return const Center(child: CircularProgressIndicator());
    } else if (state is WeatherLoaded) {
      // Loaded state: display weather details.
      return Container(
        margin: EdgeInsets.symmetric(horizontal: width / 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display the weather icon.
                WeatherIcon(
                    icon: state.weather.icon, height: height, width: width),
                // Display weather details and temperature unit switch.
                WeatherInfoWidget(
                    state: state,
                    height: height,
                    width: width,
                    isFahrenheit: isFahrenheit),
                _buildUnitSwitch(),
              ],
            ),
            // Display the refresh button.
            _refreshbutton(context, height, width)
          ],
        ),
      );
    } else if (state is WeatherError) {
      // Error state: show a snackbar with the error message.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(state.message)));
      });
    }
    // Default fallback container.
    return Container();
  }

  // Builds the temperature unit switch widget.
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
          // Switch to toggle between Fahrenheit and Celsius.
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

  // Builds the refresh button widget.
  Widget _refreshbutton(BuildContext context, double height, double width) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: height / 30),
      child: CustomNormalButton(
        buttoncolor: const Color(0xFFFF5700),
        textcolor: Colors.white,
        text: "Refresh",
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
        // Refreshes the weather data when pressed.
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
