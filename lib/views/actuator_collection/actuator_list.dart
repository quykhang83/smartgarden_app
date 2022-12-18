import 'package:flutter/material.dart';
import 'package:smartgarden_app/components/default_app_bar.dart';
import 'package:smartgarden_app/models/actuator.dart';

import 'actuator_detail.dart';

class ActuatorList extends StatelessWidget {
  static String id = "/actuatorList";
  const ActuatorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const DefaultAppBar(title: 'Actuator Collection'),
        body: ListView.builder(
            itemCount: demoActuators.length,
            itemBuilder: (context, index) {
              Actuator actuator = demoActuators[index];
              return Card(
                child: ListTile(
                  title: Text(actuator.name!),
                  // subtitle: Text(actuator.encodingType!),
                  leading: Image.asset(actuator.urlImg!),
                  trailing: const Icon(Icons.arrow_forward_rounded),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ActuatorDetail(actuator)));
                  },
                ),
              );
            }));
  }
}