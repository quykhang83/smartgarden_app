// To parse this JSON data, do
//
//     final observation = observationFromJson(jsonString);

import 'dart:convert';

List<Observation> observationFromJson(String str) => List<Observation>.from(json.decode(str).map((x) => Observation.fromJson(x)));

String observationToJson(List<Observation> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Observation {
  Observation({
    this.id,
    this.dataStreamId,
    this.result,
    this.resultTime,
    this.validTime,
  });

  int? id;
  int? dataStreamId;
  List<double>? result;
  String? resultTime;
  String? validTime;

  factory Observation.fromJson(Map<String, dynamic> json) => Observation(
    id: json["id"],
    dataStreamId: json["dataStreamId"],
    result: List<double>.from(json["result"].map((x) => x.toDouble())),
    resultTime: json["resultTime"],
    validTime: json["validTime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dataStreamId": dataStreamId,
    "result": List<dynamic>.from(result!.map((x) => x)),
    "resultTime": resultTime,
    "validTime": validTime,
  };
}
