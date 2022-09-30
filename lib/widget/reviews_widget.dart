import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smartgarden_app/controllers/api/my_api.dart';
import 'package:smartgarden_app/data/hero_tag.dart';
import 'package:smartgarden_app/data/locations.dart';
import 'package:smartgarden_app/models/location.dart';
import 'package:smartgarden_app/widget/hero_widget.dart';

import '../components/circle_progress.dart';
import '../models/observation.dart';
import '../models/sensor.dart';

class ReviewsWidget extends StatefulWidget {
  final Location location;
  final Animation<double> animation;

  const ReviewsWidget({
    required this.location,
    required this.animation,
    Key? key,
  }) : super(key: key);

  @override
  State<ReviewsWidget> createState() => _ReviewsWidgetState();
}

class _ReviewsWidgetState extends State<ReviewsWidget>
    with TickerProviderStateMixin {
  final numbers = List.generate(4, (index) => '$index');
  final controller = ScrollController();
  bool isLoading = false;

  List<Observation>? observations1 = [];
  List<Observation>? observations2 = [];
  List<Observation>? observations3 = [];
  List<Observation>? observations4 = [];
  List<Sensor> sensors = demoSensors;

  late AnimationController progressController;
  List<Animation<double>> sensorAnimations = <Animation<double>>[];

  List<double> valueObs = [32, 20, 70, 90];
  late Timer timer;
  @override
  void initState() {
    super.initState();

    //--------------------Fetch data measure----------------------//
    timer = Timer.periodic(const Duration(seconds: 10), (Timer t) => _DashboardInit());
    // double temp = -10.0;


    // temp = observations![0].result![0];
    // print(temp);
    // double humidity = 80.6;

    // isLoading = true;
  }

  _DashboardInit() async{
    observations1?.clear();
    observations2?.clear();
    observations3?.clear();
    observations4?.clear();
    await _getObsData();
    sensorAnimations.clear();
    for (int i = 0; i < demoSensors.length; i++){
      Sensor sensor = demoSensors[i];
      double value1 = valueObs[0];
      double value2 = valueObs[1];
      double value3 = valueObs[2];
      double value4 = valueObs[3];

      progressController = AnimationController(
          vsync: this, duration: const Duration(milliseconds: 1000)); //5s

      Animation<double> sensorAnimation1 =
      Tween<double>(begin: sensor.initVale, end: value1)
          .animate(progressController)
        ..addListener(() {
          setState(() {

          });
        });

      Animation<double> sensorAnimation2 =
      Tween<double>(begin: sensor.initVale, end: value2)
          .animate(progressController)
        ..addListener(() {
          setState(() {

          });
        });

      Animation<double> sensorAnimation3 =
      Tween<double>(begin: sensor.initVale, end: value3)
          .animate(progressController)
        ..addListener(() {
          setState(() {

          });
        });

      Animation<double> sensorAnimation4 =
      Tween<double>(begin: sensor.initVale, end: value4)
          .animate(progressController)
        ..addListener(() {
          setState(() {

          });
        });


      sensorAnimations.add(sensorAnimation1);
      sensorAnimations.add(sensorAnimation2);
      sensorAnimations.add(sensorAnimation3);
      sensorAnimations.add(sensorAnimation4);

      progressController.forward();
    }

  }

  _getObsData() async {
    // String token = await CallApi().getToken();
    // var data = {
    //   'token': token,
    //   'top': "all",
    // };
    //
    // debugPrint(token);

    var res1 = await CallApi().getData('get/datastreams(1)/observations');
    var res2 = await CallApi().getData('get/datastreams(2)/observations');
    var res3 = await CallApi().getData('get/datastreams(3)/observations');
    var res4 = await CallApi().getData('get/datastreams(4)/observations');




    if (res1.statusCode == 200 &&
        res2.statusCode == 200 &&
        res3.statusCode == 200 &&
        res4.statusCode == 200 ) {
      var json1 = res1.body;
      var json2 = res2.body;
      var json3 = res3.body;
      var json4 = res4.body;
      observations1 = observationFromJson(json1);
      observations2 = observationFromJson(json2);
      observations3 = observationFromJson(json3);
      observations4 = observationFromJson(json4);

      setState(() {
        valueObs[0] = observations1![0].result![0];
        valueObs[1] = observations2![0].result![0];
        valueObs[2] = observations3![0].result![0];
        valueObs[3] = observations4![0].result![0];



      });
      // valueObs[0] = observations![0].result![0];
      // print(valueObs[0]);
      print( valueObs[0]);
      print( valueObs[1]);
      print( valueObs[2]);
      print( valueObs[3]);
    } else {
      // _showMsg(body['message']);
      print("Some things was wrong!!");
    }
    if (observations1!.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
    } else {
      isLoading = false;
    }
    // observations = await RemoteService().getObservations();
  }

  @override
  void dispose() {
    timer.cancel();
    progressController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Visibility(
    visible: isLoading,
    replacement: const Center(
      child: CircularProgressIndicator(),
    ),
    child: buildGridView(),
  );

  Widget buildGridView() => GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 4 / 5,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
    ),
    padding: const EdgeInsets.all(4),
    controller: controller,
    itemCount: numbers.length,
    itemBuilder: (context, index) {
      final sensor = widget.location.sensors[index];
      final item = numbers[index];

      return AnimatedBuilder(
        animation: widget.animation,
        builder: (context, child) => FadeTransition(
          opacity: CurvedAnimation(
            parent: widget.animation,
            curve: const Interval(0.2, 1, curve: Curves.easeInExpo),
          ),
          child: child,
        ),
        child: buildSensor(item, sensor),
      );
    },
  );

  Widget buildSensor(String number, Sensor sensor) => Container(
    height: 500,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.amberAccent,
    ),
    padding: const EdgeInsets.all(16),
    // color: Colors.orange,
    child: GridTile(
      header: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HeroWidget(
            tag: HeroTag.avatar(sensor, locations.indexOf(widget.location)),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.black12,
              backgroundImage: AssetImage(sensor.urlImg),
            ),
          ),
          Text(
            sensors[int.parse(number)].name,
            textAlign: TextAlign.center,
            style:
            const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      child: Center(
          child: isLoading
              ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const SizedBox(height: 5),
              CustomPaint(
                foregroundPainter: CircleProgress(
                    value: sensorAnimations[int.parse(number)].value,
                    sensor: sensors[int.parse(number)]),
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${sensorAnimations[int.parse(number)].value.toInt()}',
                          style: const TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          sensors[int.parse(number)].unit,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
              : const Text(
            'Loading...',
            style:
            TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )),
    ),
  );
}
