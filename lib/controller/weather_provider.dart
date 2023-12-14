import 'package:flutter/material.dart';
import 'package:skycast/model/weather_model.dart';
import 'package:skycast/services/weather_api_client.dart';


class WeatherProvider extends ChangeNotifier {
  bool isLoaded = false;
  Weather? data;
  WeatherApiClient client = WeatherApiClient();



  void changeValue(bool value) {
    isLoaded = value;
    notifyListeners();
  }

    Future<void> getData(String place,) async {
    //let's try changing the city name
    data = await client.getCurrentWeather(place);
    notifyListeners();
  }

}
