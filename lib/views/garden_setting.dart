import 'package:flutter/material.dart';
import 'package:smartgarden_app/views/gardens_list.dart';

import '../../components/default_app_bar.dart';
import '../../components/default_button.dart';
import '../../size_config.dart';
import '../components/delete_button.dart';
import '../data/hero_tag.dart';
import '../models/thing.dart';
import '../widget/hero_widget.dart';

class GardenSetting extends StatefulWidget {
  final Thing thing;
  final List<int> dataSensors;

  const GardenSetting({super.key, required this.thing, required this.dataSensors});

  @override
  State<GardenSetting> createState() => _GardenSettingState();
}

class _GardenSettingState extends State<GardenSetting> {

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
      appBar: const DefaultAppBar(title: "Garden Setting"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.thing.name!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Image.network(widget.thing.avtImage!, fit: BoxFit.cover, height: 400,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.thing.description!,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 22.0),
                ),
              ),
              // const Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: DefaultButton(
                  text: "Edit",
                  press: () {

                    // _showMsg("Added ${widget.thing.name} sensor");
                    // Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: DeleteButton(
                  text: "Delete",
                  press: () {
                    // setState(() {});
                    // Navigator.pop(context);
                    _showMsg("Deleted ${widget.thing.name} garden");
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => GardensList()),
                          (route) => false,
                    );
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
