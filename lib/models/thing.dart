class Thing {
  int? id;
  String? name;
  String? description;
  String? properties;
  int? idUser;
  String? avtImage;
  int? idLocation;

  Thing(
      {this.id,
        this.name,
        this.description,
        this.properties,
        this.idUser,
        this.avtImage,
        this.idLocation});

  Thing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    properties = json['properties'];
    idUser = json['id_user'];
    avtImage = json['avt_image'];
    idLocation = json['id_location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['properties'] = properties;
    data['id_user'] = idUser;
    data['avt_image'] = avtImage;
    data['id_location'] = idLocation;
    return data;
  }
}