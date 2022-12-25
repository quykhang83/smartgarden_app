import 'package:flutter/material.dart';
import 'package:smartgarden_app/components/default_app_bar.dart';
import 'package:smartgarden_app/models/sensor.dart';
import 'package:smartgarden_app/views/sensor_collection/sensor_detail.dart';

import '../../models/thing.dart';

class SensorList extends StatelessWidget {
  final Thing thing;
  const SensorList({Key? key, required this.thing}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: const DefaultAppBar(title: 'Sensor Collection'),
        body: ListView.builder(
            itemCount: demoSensors.length,
            itemBuilder: (context, index) {
              Sensor sensor = demoSensors[index];
              return Card(
                child: ListTile(
                  title: Text(sensor.name),
                  subtitle: Text(sensor.unit),
                  leading: Image.asset(sensor.urlImg),
                  trailing: const Icon(Icons.arrow_forward_rounded),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SensorDetail(sensor, thing: thing,)));
                  },
                ),
              );
            }));
  }
}
