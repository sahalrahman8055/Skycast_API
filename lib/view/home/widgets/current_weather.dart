import 'package:flutter/material.dart';
import 'package:skycast/constants/constants.dart';
import 'package:skycast/helper/colors.dart';


Widget currentWeather(IconData icon, String temp, String location) {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        cHeight30,
        Icon(
          icon,
          color: cOrangeColor,
          size: 64.0,
        ),
       cHeight10,
        Text(
          temp,
          style: const TextStyle(fontSize: 46.0),
        ),
        cHeight10,
        Text(
          location,
          style: const TextStyle(fontSize: 18.0, color: Color(0xFF5a5a5a)),
        )
      ],
    ),
  );
}
