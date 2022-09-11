import 'package:flutter/material.dart';

class Sensor {
  final String id;
  final String name;
  final Color color;
  final double initVale;
  final int maximumValue;
  final String unit;
  final String urlImg;

  Sensor(
      {required this.id,
      required this.name,
      required this.color,
        required this.initVale,
      required this.maximumValue,
      required this.unit,
      required this.urlImg});
}

List<Sensor> demoSensors = [
  Sensor(
      id: "1",
      name: "Temperature",
      color: Colors.red,
      initVale: -50,
      maximumValue: 50,
      unit: "°C",
      urlImg: 'assets/images/temp-icon.png'),
  Sensor(
      id: "2",
      name: "Humidity",
      color: Colors.blue,
      initVale: 0,
      maximumValue: 100,
      unit: "%",
      urlImg: 'assets/images/humi-icon.png'),
  Sensor(
      id: "3",
      name: "Light",
      color: Colors.yellow,
      initVale: 0,
      maximumValue: 1000,
      unit: "lux",
      urlImg: 'assets/images/light-icon.png'),
  Sensor(
      id: "4",
      name: "CO2",
      color: Colors.green,
      initVale: 0,
      maximumValue: 100,
      unit: "%",
      urlImg: 'assets/images/co2-icon.png'),
];
