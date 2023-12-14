import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:skycast/model/weather_model.dart';

class WeatherApiClient {
  Future<Weather?> getCurrentWeather(String? location) async {
    try {
      var endpoint = Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=49b2ce818fefe7e60b6a4f7bca187d02&units=metric");

      var response = await http.get(endpoint);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        print(Weather.fromJson(body).cityName);
        return Weather.fromJson(body);
      } else {
        print("Error: ${response.statusCode}");

        return null;
      }
    } catch (e) {
      print("Error: $e");
      
      return null;
    }
  }
}
