import 'sensor.dart';
import 'actuator.dart';

class Location {
  final String name;
  final String urlImage;
  final String latitude;
  final String longitude;
  final String addressLine1;
  final String addressLine2;
  final int starRating;
  final List<Sensor> sensors;
  final List<Actuator> actuators;

  Location({
    required this.sensors,
    required this.actuators,
    required this.name,
    required this.urlImage,
    required this.latitude,
    required this.longitude,
    required this.addressLine1,
    required this.addressLine2,
    required this.starRating,
  });
}
