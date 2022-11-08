import 'package:flutter/material.dart';

class Actuator {
  int? id;
  String? name;
  ValueNotifier<bool>? controller;
  int? controlState;
  String? urlImg;
  String? description;
  int? encodingType;

  Actuator({
    this.id,
    this.name,
    this.description,
    this.encodingType,
    this.controller,
    this.controlState,
    this.urlImg
  });

  Actuator.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    controlState = json['controlState'];
    // controller?.value = (controlState == 0) ? false : true;
    description = json['description'];
    encodingType = json['encodingType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['controlState'] = controlState;
    data['description'] = description;
    data['encodingType'] = encodingType;
    return data;
  }
}

List<Actuator> demoActuators = [
  Actuator(
      id: 1,
      name: "Light new",
      controller: ValueNotifier<bool>(false),
      urlImg: 'assets/images/lightControl-icon2.png'),
  Actuator(
      id: 2,
      name: "Light",
      controller: ValueNotifier<bool>(false),
      urlImg: 'assets/images/lightControl-icon2.png'),
  Actuator(
      id: 3,
      name: "Valve",
      controller: ValueNotifier<bool>(false),
      urlImg: 'assets/images/pump-icon2.png'),
  Actuator(
      id: 4,
      name: "Valve",
      controller: ValueNotifier<bool>(false),
      urlImg: 'assets/images/pump-icon2.png'),
  Actuator(
      id: 5,
      name: "Light",
      controller: ValueNotifier<bool>(false),
      urlImg: 'assets/images/lightControl-icon2.png'),
  Actuator(
      id: 6,
      name: "Valve new",
      controller: ValueNotifier<bool>(false),
      urlImg: 'assets/images/pump-icon2.png'),
  Actuator(
      id: 7,
      name: "Valve",
      controller: ValueNotifier<bool>(false),
      urlImg: 'assets/images/pump-icon2.png'),
];
