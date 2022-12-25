import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartgarden_app/models/actuator.dart';

import '../../components/default_app_bar.dart';
import '../../components/default_button.dart';
import '../../controllers/api/my_api.dart';
import '../../models/thing.dart';
import '../../size_config.dart';
import '../main_board.dart';

class ActuatorDetail extends StatefulWidget {
  final Thing thing;
  final Actuator actuator;

  const ActuatorDetail(this.actuator, {super.key, required this.thing});

  @override
  State<ActuatorDetail> createState() => _ActuatorDetailState();
}

class _ActuatorDetailState extends State<ActuatorDetail> {
  String token = '';

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

  _addActuator() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token')!;

    var data = {
      'name': '${widget.actuator.name} in ${widget.thing.name}',
      'description': "New Actuator for controlling by ${widget.actuator.name}",
      'taskingParameters': {
        'type': "DataRecord",
        'field': [
          {
            'name': "status",
            'label': "On/Off status",
            'description': "Specifies turning the light On or Off",
            'type': "Category",
            'constraint': {
              "type": "AllowedTokens",
              "value": [0, 1]
            }
          }
        ]
      },
      'thing_id': widget.thing.id,
      'actuator_id': widget.actuator.id,
      'token': token
    };

    var res = await CallApi().postData(data, 'post/taskingcapability');
    var body = json.decode(res.body);
    print(body);
    _showMsg("Added ${widget.actuator.name} sensor to ${widget.thing.name}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const DefaultAppBar(title: sensor!.name),
      appBar: const DefaultAppBar(title: "Actuators"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.actuator.urlImg!,
                height: 500,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //     widget.sensor.unit,
              //     textAlign: TextAlign.center,
              //     style: const TextStyle(fontSize: 17.0, fontStyle: FontStyle.italic),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.actuator.description!,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 22.0),
                ),
              ),
              // const Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: DefaultButton(
                  text: "Add it actuator",
                  press: () async {
                    await _addActuator();
                    setState(() {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => MainBoard()),
                        (route) => false,
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
