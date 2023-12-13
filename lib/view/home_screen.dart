import 'package:flutter/material.dart';
import 'package:skycast/model/weather_model.dart';
import 'package:skycast/services/weather_api_client.dart';
import 'package:skycast/widget/additional_information.dart';
import 'package:skycast/widget/current_weather.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Weather? data;
  TextEditingController searchController = TextEditingController();

  Future<Weather?> getData(String city) async {
    data = await client.getCurrentWeather(city);
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData("kerala");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf9f9f9),
      appBar: AppBar(
        backgroundColor: Color(0xFFf9f9f9),
        elevation: 0.0,
        title: Text(
          'SkyCast',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: 'Enter City',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String cityName = searchController.text.trim();
                if (cityName.isNotEmpty) {
                  setState(() {
                    getData(cityName);
                  });
                }
              },
              child: Text('Search'),
            ),
            SizedBox(height: 20.0),
            FutureBuilder(
              future: getData(searchController.text
                  .trim()), // Default city value, you can change it
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      currentWeather(
                        Icons.wb_sunny_rounded,
                        "${data!.temp}",
                        "${data!.cityName}",
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Additional Information',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Color(0xdd212121),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(),
                      SizedBox(height: 20.0),
                      additionalInformation(
                        "${data!.wind}",
                        "${data!.humidity}",
                        "${data!.pressure}",
                        "${data!.feel_like}",
                      ),
                    ],
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

WeatherApiClient client = WeatherApiClient();
