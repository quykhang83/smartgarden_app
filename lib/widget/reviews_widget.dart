import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartgarden_app/controllers/api/my_api.dart';
import 'package:smartgarden_app/data/hero_tag.dart';
import 'package:smartgarden_app/data/locations.dart';
import 'package:smartgarden_app/models/location.dart';
import 'package:smartgarden_app/widget/hero_widget.dart';

import '../components/circle_progress.dart';
import '../models/DataStream.dart';
import '../models/observation.dart';
import '../models/sensor.dart';
import '../models/thing.dart';

class ReviewsWidget extends StatefulWidget {
  final Thing thing;
  final Animation<double> animation;


  const ReviewsWidget({
    required this.thing,
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

  List<Observation>? obsTemperature = [];
  List<Observation>? obsHumidity = [];
  List<Observation>? obsLight = [];
  List<Observation>? obsCO2 = [];
  List<Sensor> sensors = demoSensors;

  late AnimationController progressController;
  List<Animation<double>> sensorAnimations = <Animation<double>>[];

  List<double> valueObs = [32, 20, 70, 90];
  List<int> idDataStream = [];
  late Timer timer;
  String token = '';
  late Map<String, String> header ;
  List<DataStream> dataStream = [];
  @override
  void initState() {

    getDataStreamOfThing().then((value) {

      setState((){
        for(DataStream e in value!){
          idDataStream.add(e.id!);
        }
        dataStream.addAll(value);
      });
    });


    //--------------------Fetch data measure----------------------//
    _DashboardInit();
    timer = Timer.periodic(const Duration(seconds: 10), (Timer t) => _DashboardInit());
    // double temp = -10.0;


    // temp = observations![0].result![0];
    // print(temp);
    // double humidity = 80.6;
    super.initState();
    // isLoading = true;
  }

  _DashboardInit() async {
    print('123 $idDataStream');
    sensorAnimations.clear();
    obsTemperature?.clear();
    obsHumidity?.clear();
    obsLight?.clear();
    obsCO2?.clear();
    await _getObsData(idDataStream);
    for (int i = 0; i < dataStream.length; i++){
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

  _getObsData(List<int> index) async {
    for(int i = 0; i < index.length; i++){
      var res = await CallApi().getData('get/datastreams(${index[i]})/observations');
      var body = json.decode(res.body);
      //Light
      if (res.statusCode == 200 && index[i] == 1 ) {
        var json1 = res.body;
        obsLight = observationFromJson(json1);
        setState(() {
          valueObs[index[i] - 1] = obsLight![0].result![0];
        });
        // valueObs[0] = observations![0].result![0];
        // print(valueObs[0]);

      }
      //CO2
      else if (res.statusCode == 200 && index[i] == 2 ) {
        var json1 = res.body;
        obsCO2= observationFromJson(json1);
        setState(() {
          valueObs[index[i] - 1] = obsCO2![0].result![0];
        });
        // valueObs[0] = observations![0].result![0];
        // print(valueObs[0]);

      }
      //Temperature
      else if (res.statusCode == 200 && index[i] == 3 ) {
        var json1 = res.body;
        obsTemperature = observationFromJson(json1);
        setState(() {
          valueObs[index[i] - 1] = obsTemperature![0].result![0];
        });
        // valueObs[0] = observations![0].result![0];
        // print(valueObs[0]);

      }
      //Hum
      else if (res.statusCode == 200 && index[i] == 4 ) {
        var json1 = res.body;
        obsHumidity = observationFromJson(json1);
        setState(() {
          valueObs[index[i] - 1] = obsHumidity![0].result![0];
        });
        // valueObs[0] = observations![0].result![0];
        // print(valueObs[0]);

      }
      else {
        // _showMsg(body['message']);
        print("Some things was wrong!!");
      }
      if (body.toString().isNotEmpty) {
        setState(() {
          isLoading = true;
        });
      } else {
        isLoading = false;
      }
    }

    // observations = await RemoteService().getObservations();
  }

  Future<List<DataStream>?> getDataStreamOfThing() async {
    var res = await CallApi().getData('get/things(${widget.thing.id})/datastreams?top=all');
    var body = json.decode(res.body);
    if (body.toString().isNotEmpty) {
      var thing = body as List<dynamic>;
      var data = thing.map((e) => DataStream.fromJson(e)).toList();
      return data;
    } else {
      return null;
    }
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
      final sensor = demoSensors[index];
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
          // HeroWidget(
          //   tag: HeroTag.avatar(sensor, locations.indexOf(locations)),
          //   child: CircleAvatar(
          //     radius: 16,
          //     backgroundColor: Colors.black12,
          //     backgroundImage: AssetImage(sensor.urlImg),
          //   ),
          // ),
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
                    value: sensorAnimations.isNotEmpty ? sensorAnimations[int.parse(number)].value : 0,
                    sensor: sensors[int.parse(number)]),
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          sensorAnimations.isNotEmpty ? '${sensorAnimations[int.parse(number)].value.toInt()}' : '',
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
