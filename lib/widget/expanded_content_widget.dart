import 'package:flutter/material.dart';
import 'package:smartgarden_app/data/hero_tag.dart';
import 'package:smartgarden_app/data/locations.dart';
import 'package:smartgarden_app/models/location.dart';
import 'package:smartgarden_app/models/thing.dart';
import 'package:smartgarden_app/widget/hero_widget.dart';
import 'package:smartgarden_app/widget/stars_widget.dart';

class ExpandedContentWidget extends StatelessWidget {
  final Thing thing;

  const ExpandedContentWidget({
    required this.thing,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children:  [
            // HeroWidget(
            //   tag: HeroTag.addressLine1(thing),
            //   child: Text(thing),
            // ),
            SizedBox(height: 8),
            // buildAddressRating(thing: thing),
            SizedBox(height: 12),
            // buildReview(t: thing)
          ],
        ),
      );

  // Widget buildAddressRating({
  //   required Thing thing,
  // }) =>
  //     Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         HeroWidget(
  //           tag: HeroTag.addressLine2(thing),
  //           child: Text(
  //             thing.name.toString(),
  //             style: TextStyle(color: Colors.black45),
  //           ),
  //         ),
  //         HeroWidget(
  //           tag: HeroTag.stars(location),
  //           child: StarsWidget(stars: location.starRating),
  //         ),
  //       ],
  //     );

  Widget buildReview({
    required Location location,
  }) =>
      Row(
        children: location.sensors.map((sensor) {
          final pageIndex = locations.indexOf(location);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: HeroWidget(
              tag: HeroTag.avatar(sensor, pageIndex),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.black12,
                backgroundImage: AssetImage(sensor.urlImg),
              ),
            ),
          );
        }).toList(),
      );
}
