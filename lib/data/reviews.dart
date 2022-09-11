import 'package:smartgarden_app/models/review.dart';

class Reviews {
  static List<Review> allReviews = [
    Review(
      date: 'FEB 14th',
      username: 'Temperature',
      urlImage: 'assets/images/temp-icon.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
    ),
    Review(
      date: 'JAN 24th',
      username: 'Humidity',
      urlImage: 'assets/images/humi-icon.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
    ),
    Review(
      date: 'MAR 18th',
      username: 'Light',
      urlImage: 'assets/images/light-icon.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
    ),
    Review(
      date: 'AUG 15th',
      username: 'CO2',
      urlImage: 'assets/images/co2-icon.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
    ),
  ];
}
