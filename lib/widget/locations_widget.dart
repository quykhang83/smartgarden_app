import 'package:flutter/material.dart';
import 'package:smartgarden_app/data/locations.dart';

import 'location_widget.dart';

class LocationsWidget extends StatefulWidget {
  @override
  _LocationsWidgetState createState() => _LocationsWidgetState();
}

class _LocationsWidgetState extends State<LocationsWidget> {
  final pageController = PageController(viewportFraction: 0.8);
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          SizedBox(height: 30),
          Text(
            '${pageIndex + 1}/${locations.length}',
            style: TextStyle(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: locations.length,
              itemBuilder: (context, index) {
                final location = locations[index];

                return LocationWidget(location: location);
              },
              onPageChanged: (index) => setState(() => pageIndex = index),
            ),
          ),
          SizedBox(height: 60)
        ],
      );
}
