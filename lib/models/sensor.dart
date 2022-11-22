import 'package:flutter/material.dart';

class Sensor {
  final String id;
  final String name;
  final Color color;
  final double initVale;
  final double maximumValue;
  final String unit;
  final String urlImg;
  final String description;

  Sensor(
      {required this.id,
      required this.name,
      required this.color,
        required this.initVale,
      required this.maximumValue,
      required this.unit,
      required this.urlImg,
      required this.description});
}

List<Sensor> demoSensors = [
  Sensor(
      id: "1",
      name: "Light",
      color: Colors.yellow,
      initVale: 0,
      maximumValue: 1000,
      unit: "lux",
      urlImg: 'assets/images/light-icon.png',
      description: "Lorem Ipsum is simply dummy text of the printing and "
          "typesetting industry. Lorem Ipsum has been the industry's "
          "standard dummy text ever since the 1500s"),
  Sensor(
      id: "2",
      name: "CO2",
      color: Colors.green,
      initVale: 0,
      maximumValue: 100,
      unit: "ppm",
      urlImg: 'assets/images/co2-icon.png',
      description: "Lorem Ipsum is simply dummy text of the printing and "
          "typesetting industry. Lorem Ipsum has been the industry's "
          "standard dummy text ever since the 1500s"),
  Sensor(
      id: "3",
      name: "Temperature",
      color: Colors.red,
      initVale: 0,
      maximumValue: 50,
      unit: "°C",
      urlImg: 'assets/images/temp-icon.png',
      description: "Lorem Ipsum is simply dummy text of the printing and "
          "typesetting industry. Lorem Ipsum has been the industry's "
          "standard dummy text ever since the 1500s"
  ),
  Sensor(
      id: "4",
      name: "Humidity",
      color: Colors.blue,
      initVale: 0,
      maximumValue: 100,
      unit: "%",
      urlImg: 'assets/images/humi-icon.png',
      description: "Lorem Ipsum is simply dummy text of the printing and "
          "typesetting industry. Lorem Ipsum has been the industry's "
          "standard dummy text ever since the 1500s"
  ),
  Sensor(
      id: "5",
      name: "Soil",
      color: Colors.blue,
      initVale: 0,
      maximumValue: 100,
      unit: "%",
      urlImg: 'assets/images/soil-sensor.png',
      description: "Lorem Ipsum is simply dummy text of the printing and "
          "typesetting industry. Lorem Ipsum has been the industry's "
          "standard dummy text ever since the 1500s"
  )
];
