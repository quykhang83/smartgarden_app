import 'package:flutter/material.dart';
import 'package:smartgarden_app/models/sensor.dart';

import '../../components/default_app_bar.dart';
import '../../components/default_button.dart';
import '../../size_config.dart';

class SensorDetail extends StatefulWidget {
  final Sensor sensor;

  const SensorDetail(this.sensor, {super.key});

  @override
  State<SensorDetail> createState() => _SensorDetailState();
}

class _SensorDetailState extends State<SensorDetail> {

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
                  press: () {
                    // setState(() {});
                    // Navigator.pop(context);
                    _showMsg("Added ${widget.sensor.name} sensor");
                    Navigator.pop(context);
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
