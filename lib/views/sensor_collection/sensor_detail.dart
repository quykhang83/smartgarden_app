import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartgarden_app/models/sensor.dart';
import 'package:smartgarden_app/widget/location_widget.dart';

import '../../components/default_app_bar.dart';
import '../../components/default_button.dart';
import '../../controllers/api/my_api.dart';
import '../../models/thing.dart';
import '../../size_config.dart';
import '../main_board.dart';

class SensorDetail extends StatefulWidget {
  final Thing thing;
  final Sensor sensor;

  const SensorDetail(this.sensor, {super.key, required this.thing});

  @override
  State<SensorDetail> createState() => _SensorDetailState();
}

class _SensorDetailState extends State<SensorDetail> {
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

  _addSensor() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token')!;

    var data = {
      'Sensor': widget.sensor.id,
      'Thing': widget.thing.id,
      'name': '${widget.sensor.name} in ${widget.thing.name}',
      'description': "New DataStream for recording ${widget.sensor.name}",
      // 'avt_image': File(selectedImagePath),
      'token': token
    };

    var res = await CallApi().postData(data, 'post/datastreams');
    var body = json.decode(res.body);
    print(body);
    _showMsg("Added ${widget.sensor.name} sensor to ${widget.thing.name}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const DefaultAppBar(title: sensor!.name),
      appBar: const DefaultAppBar(title: "Sensors"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.sensor.urlImg,
                height: 500,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.sensor.unit,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 17.0, fontStyle: FontStyle.italic),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.sensor.description,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 22.0),
                ),
              ),
              // const Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: DefaultButton(
                  text: "Add it sensor",
                  press: () async {
                    // setState(() {});
                    // Navigator.pop(context);
                    // _showMsg("Added ${widget.sensor.name} sensor");
                    await _addSensor();
                    setState(() {
                      // ThingWidget.of(context)?.initState();
                      // Navigator.pop(context);
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
