import 'package:smartgarden_app/models/actuator.dart';
import 'package:smartgarden_app/models/location.dart';

import '../models/sensor.dart';

class HeroTag {
  static String image(String urlImage) => urlImage;

  static String addressLine1(Location location) =>
      location.name + location.addressLine1;

  static String addressLine2(Location location) =>
      location.name + location.addressLine2;

  static String stars(Location location) =>
      location.name + location.starRating.toString();

  static String avatar(Sensor sensor, int position) =>
      sensor.urlImg + position.toString();

  static String avatar2(Actuator actuator, int position) =>
      actuator.urlImg! + position.toString();

  static String avatar3(int sensorId, int position) =>
      demoSensors[sensorId-1].urlImg + position.toString();
}
