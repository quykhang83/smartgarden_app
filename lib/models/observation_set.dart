// To parse this JSON data, do
//
//     final observation = observationFromJson(jsonString);

import 'dart:convert';

import 'package:smartgarden_app/models/observation.dart';

ObservationSet observationFromJson(String str) => ObservationSet.fromJson(json.decode(str));

String observationToJson(ObservationSet data) => json.encode(data.toJson());

class ObservationSet {
  ObservationSet({
    required this.value,
    required this.nextLink,
  });

  List<Observation> value;
  String nextLink;

  factory ObservationSet.fromJson(Map<String, dynamic> json) => ObservationSet(
    value: List<Observation>.from(json["value"].map((x) => Observation.fromJson(x))),
    nextLink: json["nextLink"],
  );

  Map<String, dynamic> toJson() => {
    "value": List<Observation>.from(value.map((x) => x.toJson())),
    "nextLink": nextLink,
  };
}
