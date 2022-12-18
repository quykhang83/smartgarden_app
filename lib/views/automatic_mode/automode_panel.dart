import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartgarden_app/models/task_status.dart';
import 'package:smartgarden_app/views/automatic_mode/slider_widget.dart';
import '../../components/background_image.dart';
import '../../components/default_button.dart';
import '../../controllers/api/my_api.dart';
import '../../models/actuator.dart';
import '../../models/sensor.dart';
import '../../models/thing.dart';

class AutoModePanel extends StatefulWidget {
  final Thing thing;
  final List<Thing> listThing;
  final List<int> dataSensors;
  final bool autoState;

  const AutoModePanel(
      {Key? key,
      required this.thing,
      required this.listThing,
      required this.dataSensors,
      required this.autoState})
      : super(key: key);

  @override
  State<AutoModePanel> createState() => AutoModePanelState();

  // note: updated as context.ancestorStateOfType is now deprecated
  static AutoModePanelState? of(BuildContext context) =>
      context.findAncestorStateOfType<AutoModePanelState>();
}

class AutoModePanelState extends State<AutoModePanel> {
  late bool isSelected;
  List<double> autoValues = [];
  List<Actuator> actuators = [];

  @override
  void initState() {
    super.initState();
    isSelected = widget.autoState;
    _getAutoState();
    getActuatorOfThing().then((value) {
      //fetch default data of actuator//
      setState(() {
        for (Actuator e in value!) {
          print(
              "${e.id}: ${e.name} - ${e.controlState} - ${e.controller?.value}");
          e.controller = (e.controlState == 0)
              ? ValueNotifier<bool>(false)
              : ValueNotifier<bool>(true);

          actuators.add(e);
          autoValues.add(0);
        }
      });

      _getAutoData();
    });

  }

  _getAutoData() async {
    for(int i = 0; i < actuators.length; i++){
      TaskStatus temp = TaskStatus();
      var res = await CallApi().getData('IoTTask/task(${actuators[i].id},${widget.thing.id})');
      var body = json.decode(res.body);
      print(body);

      if (res.statusCode == 200) {
        // var json1 = res.body;
        temp = TaskStatus.fromJson(body);

        setState(() {
          autoValues[i] = temp.status!.toDouble();
          print("AutomodePanel $i: ${autoValues[i]}");
        });
      }
      else {
        print("Some things was wrong!!");
      }
    }
  }

  _getAutoState() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    isSelected = localStorage.getBool('autoState${widget.thing.id}')!;
  }

  _setAutoState(bool autoState) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setBool('autoState${widget.thing.id}', autoState);
    isSelected = localStorage.getBool('autoState${widget.thing.id}')!;
  }

  Future<List<Actuator>?> getActuatorOfThing() async {
    var res = await CallApi()
        .getData('get/things(${widget.thing.id})/actuator?top=all');
    var body = json.decode(res.body);
    if (body.toString().isNotEmpty) {
      var thing = body as List<dynamic>;
      var data = thing.map((e) => Actuator.fromJson(e)).toList();
      print("Get data actuator success!!!");
      return data;
    } else {
      print("Some things were wrong!");
      return null;
    }
  }

  _postActuatorState(
      int taskingParameters, int thing_id, int actuator_id) async {
    var token = await CallApi().getToken();
    var data = {
      'taskingParameters': taskingParameters,
      'thing_id': thing_id,
      'actuator_id': actuator_id,
      'token': token
    };

    var res = await CallApi().postData(data, 'post/task');
    var body = json.decode(res.body);
    print(body);
  }

  _saveActuatorState() {
    for (int i = 0; i < actuators.length; i++) {
      actuators[i].controlState = -1;
      _postActuatorState(autoValues[i].round(), widget.thing.id!, actuators[i].id!);

      print("${actuators[i].name}: ${autoValues[i].round()}");
    }
    _showMsg("Updated automatic mode");
  }

  _showMsg(msg) {
    //
    final snackBar = SnackBar(
      backgroundColor: const Color(0xff0a8f2e),
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        textColor: Colors.white,
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width;
    return Stack(children: <Widget>[
      const BackgroundImage(
        image: 'assets/images/bg-login.jpg',
      ),
      Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.green,
            title: const Text(
              'Automatic Mode',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, true),
            ),
            actions: [
              Switch(
                onChanged: (value) {
                  setState(() {
                    isSelected = value;
                    _setAutoState(isSelected);
                    print(isSelected);
                  });
                },
                value: isSelected,
                activeColor: Colors.amber,
              )
            ],
          ),
          body: isSelected
              ? Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: actuators.length,
                        itemBuilder: (context, index) {
                          Actuator actuator = actuators[index];
                          return Card(
                            color: Colors.amberAccent,
                            margin: const EdgeInsets.all(4),
                            child: ListTile(
                              title: Text(
                                '${actuator.name}',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              subtitle: ListView.builder(
                                  // itemCount: widget.dataSensors.length,
                                  itemCount: 1,
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index2) {
                                    // if(widget.dataSensors[index] == 1)
                                    Sensor sensor = demoSensors[
                                        widget.dataSensors[index2] - 1];
                                    if (actuator.id == 2) {
                                      sensor = demoSensors[0];
                                    } else if (actuator.id == 7) {
                                      sensor = demoSensors[4];
                                    }
                                    return Card(
                                      color: Colors.green[100],
                                      child: ListTile(
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "${sensor.name} / ${sensor.unit}",
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(height: 8),
                                          ],
                                        ),
                                        subtitle: Row(
                                          children: [
                                            SliderWidget(initVal: autoValues[index],
                                                index: index, sensor: sensor)
                                          ],
                                        ),
                                        leading: Image.asset(sensor.urlImg),
                                      ),
                                    );
                                  }),
                            ),
                          );
                        }),
                    const SizedBox(height: 15),
                    actuators.isNotEmpty
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: DefaultButton(
                              text: "Save",
                              press: () {
                                print("${autoValues[0]} - ${autoValues[1]}");
                                _saveActuatorState();
                                setState(() {});
                                // _showMsg("Updated automatic mode");
                              },
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.all(10.0),
                            width: cWidth,
                            child: Column(
                              children: const <Widget>[
                                Text(
                                    "You don't have any actuator to use automatic mode.\nAdd actuators to your garden!",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center),
                              ],
                            ),
                          )
                  ],
                )
              : Container(
                  padding: const EdgeInsets.all(10.0),
                  width: cWidth,
                  child: Column(
                    children: const <Widget>[
                      Text(
                          "You can turn on automatic mode and set up your environment params",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                    ],
                  ),
                )),
    ]);
  }
}
