class DataStream {
  int? id;
  int? sensorId;
  String? name;
  String? description;
  String? observationType;

  DataStream({this.id, this.sensorId, this.name, this.description, this.observationType});

  DataStream.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sensorId = json['sensorId'];
    name = json['name'];
    description = json['description'];
    observationType = json['observationType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sensorId'] = sensorId;
    data['name'] = name;
    data['description'] = description;
    data['observationType'] = observationType;
    return data;
  }
}