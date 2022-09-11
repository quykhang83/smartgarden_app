import 'package:flutter/material.dart';
import 'package:smartgarden_app/components/custom_app_bar.dart';
import 'package:smartgarden_app/widget/locations_widget.dart';

import '../components/background-image.dart';

class GardensList extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        // extendBodyBehindAppBar: true,
        // backgroundColor: Colors.blueGrey,
        appBar: const CustomAppBar(title: 'YOUR GARDEN'),
        body: Stack(
          children: [
            const BackgroundImage(
              image: 'assets/images/bg-garden.jpg',
            ),
            LocationsWidget(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {},
        ),
        // bottomNavigationBar: buildBottomNavigation(),
      );

  Widget buildBottomNavigation() => BottomNavigationBar(
        elevation: 0,
        unselectedItemColor: Colors.white54,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.pin_drop_outlined),
            label: 'Add one',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_location),
            label: '',
          ),
        ],
      );
}
