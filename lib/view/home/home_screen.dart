import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skycast/constants/constants.dart';
import 'package:skycast/controller/weather_provider.dart';
import 'package:skycast/helper/colors.dart';
import 'package:skycast/services/weather_api_client.dart';
import 'package:skycast/view/home/widgets/additional_information.dart';
import 'package:skycast/view/home/widgets/current_weather.dart';
import 'package:skycast/view/widget/uppercase.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController weatherController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<WeatherProvider>(context, listen: false).getData('London');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // backgroundColor: Colors.grey[300],

        title: const Text(
          "Skycast",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Consumer<WeatherProvider>(
          builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    onFieldSubmitted: (String place) {
                      value.getData(
                        place,
                      );
                    },
                    controller: weatherController,
                    cursorColor: cBlackColor,
                    style: const TextStyle(
                      fontSize: 20,
                      color: cBlackColor,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 18),
                        isDense: true,
                        hintText: "Search",
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.search,
                            size: 30,
                          ),
                        ),
                        suffixIcon: weatherController.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  weatherController.clear();
                                },
                                icon:
                                    const Icon(Icons.cancel, color: cRedColor))
                            : null),
                  ),
                ),
                cHeight20,
                if (value.data != null)
                  currentWeather(
                    Icons.wb_sunny_rounded,
                    "${value.data!.temp}°",
                    weatherController.text.isEmpty
                        ? 'London'
                        : weatherController.text.capitalize(),
                  ),
                cHeight60,
                const Text(
                  'Additional information',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: cBlackColor45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                cHeight10,
                if (value.data != null)
                  additionalInformation(
                      "${value.data!.wind}",
                      "${value.data!.humidity}",
                      "${value.data!.pressure}",
                      "${value.data!.feels_like}"),
                Text(
                  errormessage,
                  style: TextStyle(fontSize: 20),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
