import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartgarden_app/views/automatic_mode/slider_widget.dart';
import '../../controllers/api/my_api.dart';
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
  State<AutoModePanel> createState() => _AutoModePanelState();
}

class _AutoModePanelState extends State<AutoModePanel> {
  late bool isSelected;
  List<int> autoValues = [];

  @override
  void initState() {
    isSelected = widget.autoState;
    _getAutoState();
    super.initState();
  }

  _getAutoState() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    isSelected = localStorage.getBool('autoState')!;
  }

  _setAutoState(bool autoState) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setBool('autoState', autoState);
    isSelected = localStorage.getBool('autoState')!;
  }

  _postActuatorAutoModeState(
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

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
            ? ListView.builder(
                itemCount: widget.dataSensors.length,
                itemBuilder: (context, index) {
                  Sensor sensor = demoSensors[index];
                  return Card(
                    color: Colors.green[100],
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${sensor.name} / ${sensor.unit}",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          // Text(sensor.unit),
                          SliderWidget(sensor: sensor)
                        ],
                      ),
                      leading: Image.asset(sensor.urlImg),
                    ),
                  );
                })
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
              ));
  }
}
