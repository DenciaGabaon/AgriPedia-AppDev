import 'package:agripedia/services/weather_services.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:agripedia/models/weather_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
class WeatherPage extends StatefulWidget{
  const WeatherPage ({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage>{
  // api key
  final _weatherService = WeatherService('69f09570cf84c79905679549935efb45');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async{
    // get current city
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city
    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather =  weather;
      });
    }
    catch(e){
      print('Error getting location: $e');
    }
  }

  // weather animation
  String getWeatherAnimation(String? mainCondition){
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()){
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.svg';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.svg';
      case 'thunderstorm':
        return 'assets/thunder.svg';
      case 'clear':
        return 'assets/sunny.svg';
      default: return 'assets/sunny.svg';
    }
  }

  @override
  void initState(){
    super.initState();

    // fetch weather on start
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context){
    // Get Current Date
    DateTime currentDate = DateTime.now();
    String formattedDate = "${currentDate.day}/${currentDate.month}/${currentDate.year}";

    return
      Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(230, 242, 214, 1),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0,3),
            ),
          ],
        ),
        width: 370,
        height: 180,
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(getWeatherAnimation(_weather?.mainCondition), height:90, width: 90),
                  Text(
                    _weather?.mainCondition ?? "",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Inter',
                      color: const Color.fromRGBO(38, 50, 56, 1),
                    ),
                  ),
                  Text(
                    'Today, $formattedDate',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Inter',
                      color: const Color.fromRGBO(38, 50, 56, 1),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_weather?.temperature.round()}°C',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                      color: const Color.fromRGBO(38, 50, 56, 1),
                    ),
                  ),
                  Text(
                    _weather?.cityName ?? "Loading City...",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Inter',
                      color: const Color.fromRGBO(38, 50, 56, 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }
}