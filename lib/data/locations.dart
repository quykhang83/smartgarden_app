import 'package:smartgarden_app/models/actuator.dart';
import 'package:smartgarden_app/models/location.dart';
import 'package:smartgarden_app/models/sensor.dart';

List<Location> locations = [
  Location(
    name: 'CUSC - DEMOTREE',
    urlImage: 'assets/images/cusc-tree.jpg',
    addressLine1: 'La Cresenta-Montrose, CA91020 Glendale',
    addressLine2: 'NO. 791187',
    starRating: 4,
    latitude: 'NORTH LAT 24',
    longitude: 'EAST LNG 17',
    sensors: demoSensors,
    actuators: demoActuators,
  ),
  Location(
    name: 'CUSC GARDEN',
    urlImage: 'assets/images/cusc-garden.jpg',
    addressLine1: 'La Cresenta-Montrose, CA91020 Glendale',
    addressLine2: 'NO. 11641',
    starRating: 4,
    latitude: 'SOUTH LAT 14',
    longitude: 'EAST LNG 27',
    sensors: demoSensors,
    actuators: demoActuators,
  ),
  Location(
    name: 'KHANG\'S GARDEN',
    urlImage: 'assets/images/khang-garden.jpg',
    addressLine1: 'La Cresenta-Montrose, CA91020 Glendale',
    addressLine2: 'NO. 791187',
    starRating: 4,
    latitude: 'NORTH LAT 24',
    longitude: 'WEST LNG 08',
    sensors: demoSensors,
    actuators: demoActuators,
  ),
  Location(
    name: 'NGHIA\'S GARDEN',
    urlImage: 'assets/images/nghia-garden.jpg',
    addressLine1: 'La Cresenta-Montrose, CA91020 Glendale',
    addressLine2: 'NO. 791187',
    starRating: 4,
    latitude: 'SOUTH LAT 39',
    longitude: 'WEST LNG 41',
    sensors: demoSensors,
    actuators: demoActuators,
  ),
];
