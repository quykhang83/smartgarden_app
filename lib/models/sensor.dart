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
      maximumValue: 3000,
      unit: "lux",
      urlImg: 'assets/images/light-icon.png',
      description:
          "A light sensor is a photoelectric device that converts light energy (photons) detected to electrical energy (electrons). Seems simple? There is more to a light sensor than just its definition. It comes in different types and is used in various applications!"),
  Sensor(
      id: "2",
      name: "CO2",
      color: Colors.green,
      initVale: 0,
      maximumValue: 10000,
      unit: "ppm",
      urlImg: 'assets/images/co2-icon.png',
      description:
          "A carbon dioxide (CO2) sensor is a device used to measure the concentration of carbon dioxide gas in the atmosphere. It is measured using “parts per million” (ppm) and typically has a presence of around 400 ppm. "),
  Sensor(
      id: "3",
      name: "Temperature",
      color: Colors.red,
      initVale: 0,
      maximumValue: 100,
      unit: "°C",
      urlImg: 'assets/images/temp-icon.png',
      description:
          "A temperature sensor is an electronic device that measures the temperature of its environment and converts the input data into electronic data to record, monitor, or signal temperature changes."),
  Sensor(
      id: "4",
      name: "Humidity",
      color: Colors.blue,
      initVale: 0,
      maximumValue: 100,
      unit: "%",
      urlImg: 'assets/images/humi-icon.png',
      description:
          "A humidity sensor is an electronic device that measures the humidity in its environment and converts its findings into a corresponding electrical signal. Humidity sensors vary widely in size and functionality."),
  Sensor(
      id: "5",
      name: "Soil",
      color: Colors.blue,
      initVale: 0,
      maximumValue: 100,
      unit: "%",
      urlImg: 'assets/images/soil-sensor.png',
      description:
          "Soil moisture sensors (or “volumetric water content sensors”) measure the water content in soil, and can be used to estimate the amount of stored water in a profile, or how much irrigation is required to reach a desired amount of saturation.")
];
