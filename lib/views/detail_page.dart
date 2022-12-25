import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartgarden_app/data/hero_tag.dart';
import 'package:smartgarden_app/data/locations.dart';
import 'package:smartgarden_app/models/location.dart';
import 'package:smartgarden_app/views/actuator_collection/actuator_list.dart';
import 'package:smartgarden_app/views/control_panel.dart';
import 'package:smartgarden_app/views/sensor_collection/sensor_list.dart';
import 'package:smartgarden_app/views/singup_login/login_screen.dart';
import 'package:smartgarden_app/widget/hero_widget.dart';
import 'package:smartgarden_app/widget/reviews_widget.dart';

import '../components/background_image.dart';
import '../models/thing.dart';
import 'automatic_mode/automode_panel.dart';
import 'garden_setting.dart';
import 'gardens_list.dart';

class DetailPage extends StatefulWidget {
  final Thing thing;
  final List<Thing> listThing;
  final Animation<double> animation;
  final List<int> dataSensors;

  DetailPage({
    required this.thing,
    required this.listThing,
    required this.animation,
    required this.dataSensors,
    Key? key,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool autoState = false;

  @override
  void initState() {
    _getAutoState();
    super.initState();
  }

  _getAutoState() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    // localStorage.setString('token', body['token']);
    var autoVal = localStorage.getBool('autoState${widget.thing.id}');
    if (autoVal == null) {
      localStorage.setBool('autoState${widget.thing.id}', false);
      autoVal = false;
    }
    setState(() {
      autoState = autoVal!;
    });
    print(autoState);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0x80111010),
        title: Text(
          widget.thing.name.toString(),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: Navigator.of(context).pop,
        ),
        actions: [
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.white),
              textTheme: const TextTheme().apply(bodyColor: Colors.white),
            ),
            child: PopupMenuButton<int>(
              color: const Color(0xCC1AB422),
              position: PopupMenuPosition.under,
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    children: const [
                      Icon(Icons.edgesensor_high_rounded),
                      SizedBox(width: 8),
                      Text('Add sensors',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    children: const [
                      Icon(Icons.control_camera_rounded),
                      SizedBox(width: 8),
                      Text('Add actuators',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                PopupMenuItem<int>(
                  value: 2,
                  child: Row(
                    children: const [
                      Icon(Icons.auto_mode_rounded),
                      SizedBox(width: 8),
                      Text('Auto Mode',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                PopupMenuItem<int>(
                  value: 3,
                  child: Row(
                    children: const [
                      Icon(Icons.settings),
                      SizedBox(width: 8),
                      Text('Settings',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem<int>(
                  value: 4,
                  child: Row(
                    children: const [
                      Icon(Icons.logout),
                      SizedBox(width: 8),
                      Text('Log Out',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('token');
                    prefs.remove("user");
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext ctx) => LoginScreen()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: true,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox.expand(
                        child: HeroWidget(
                          tag: HeroTag.image(widget.thing.avtImage.toString()),
                          child: Image.network(widget.thing.avtImage.toString(),
                              fit: BoxFit.cover),
                        ),
                      ),
                      // Container(
                      //   padding: const EdgeInsets.all(8),
                      //   child: LatLongWidget(location: location),
                      // ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 7,
                    child: Container(
                      color: Colors.lightGreen[900],
                      child: ReviewsWidget(
                          thing: widget.thing,
                          listThing: widget.listThing,
                          animation: widget.animation,
                          dataSensors: widget.dataSensors),
                    )),
                Expanded(
                  flex: 1,
                  child: autoState
                      ? Stack(
                          children: [
                            const BackgroundImage(
                              image: 'assets/images/control-panel-bg.jpg',
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              color: const Color(0x80111010),
                              child: Column(
                                children: const [
                                  Text(
                                      "You are in Auto mode, turn it off for Manual control",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      textAlign: TextAlign.center),
                                ],
                              ),
                            )
                          ],
                        )
                      : Container(
                          color: Colors.indigo,
                          child: ControlPanel(
                              thing: widget.thing, listThing: widget.listThing),
                        ),
                )
              ],
            ),
          ),
        ],
      ));

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        print("Tap to sensor list!");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext ctx) =>
                    SensorList(thing: widget.thing)));
        break;
      case 1:
        print("Tap to actuator list!");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext ctx) =>
                    ActuatorList(thing: widget.thing)));
        break;
      case 2:
        print("Tap to automatic mode!");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext ctx) => AutoModePanel(
                      thing: widget.thing,
                      listThing: widget.listThing,
                      dataSensors: widget.dataSensors,
                      autoState: autoState,
                    ))).then((value) => {if (value) _getAutoState()});
        break;
      case 3:
        print("Tap to Setting!");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext ctx) => GardenSetting(
                      thing: widget.thing,
                      dataSensors: widget.dataSensors,
                    )));
        break;
      case 4:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
    }
  }
}
