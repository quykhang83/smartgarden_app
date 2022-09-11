import 'package:flutter/material.dart';

class Actuator {
  final String id;
  final String name;
  final ValueNotifier<bool> controller;
  final String urlImg;

  Actuator(
      {required this.id,
        required this.name,
        required this.controller,
        required this.urlImg});
}

List<Actuator> demoActuators = [
  Actuator(
      id: "1",
      name: "Pump",
      controller: ValueNotifier<bool>(false),
      urlImg: 'assets/images/pump-icon2.png'),
  Actuator(
      id: "2",
      name: "Light",
      controller: ValueNotifier<bool>(false),
      urlImg: 'assets/images/lightControl-icon2.png'),
];
