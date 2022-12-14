import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:smartgarden_app/components/background_image.dart';
import 'package:smartgarden_app/models/actuator.dart';

import '../controllers/api/my_api.dart';
import '../data/hero_tag.dart';
import '../models/thing.dart';
import '../widget/hero_widget.dart';

class ControlPanel extends StatefulWidget {
  final Thing thing;
  final List<Thing> listThing;

  const ControlPanel({
    Key? key,
    required this.thing,
    required this.listThing,
  }) : super(key: key);

  @override
  State<ControlPanel> createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel>
    with TickerProviderStateMixin {
  // 0. Quantity of controller
  // final numbers = List.generate(2, (index) => '$index');
  final scrollController = ScrollController();

  // 1. Create a controller in the state of the StatefulWidget
  // final _controller = ValueNotifier<bool>(false);

  // 2. In case, you want to call setState on switch changes.
  // 2.1. Add event listener, for example in the initState() method.
  // ...

  List<Actuator> actuators = [];

  @override
  void initState() {
    super.initState();

    getActuatorOfThing().then((value) {
      setState(() {
        for (Actuator e in value!) {
          print(
              "${e.id}: ${e.name} - ${e.controlState} - ${e.controller?.value}");
          //Determine on/off after turn off AutoMode
          e.controller = (e.controlState == -1)
              ? ValueNotifier<bool>(true)
              : ValueNotifier<bool>(false);

          actuators.add(e);
        }
        for (int i = 0; i < actuators.length; i++) {
          actuators[i].controller?.addListener(() {
            setState(() {
              if (actuators[i].controller!.value) {
                actuators[i].controlState = -1;
                _postActuatorState(-1, widget.thing.id!, actuators[i].id!);
              } else {
                actuators[i].controlState = 0;
                _postActuatorState(0, widget.thing.id!, actuators[i].id!);
              }
              print("${actuators[i].name}: ${actuators[i].controller!.value}");
            });
          });
        }
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<List<Actuator>?> getActuatorOfThing() async {
    var res = await CallApi()
        .getData('get/things(${widget.thing.id})/actuator?top=all');
    var body = json.decode(res.body);
    if (body.toString().isNotEmpty) {
      var thing = body as List<dynamic>;
      var data = thing.map((e) => Actuator.fromJson(e)).toList();
      print("Get data success!!!");
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

    // debugPrint();

    var res = await CallApi().postData(data, 'post/task');
    var body = json.decode(res.body);
    print(body);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(
          image: 'assets/images/control-panel-bg.jpg',
        ),
        actuators.isNotEmpty
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 0.34,
                  mainAxisSpacing: 8, //comment it
                  crossAxisSpacing: 8,
                ),
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(4),
                controller: scrollController,
                itemCount: actuators.length,
                itemBuilder: (context, index) {
                  final actuator = actuators[index];
                  final item = actuators[index].id;

                  return buildActuator(item.toString(), actuator);
                },
              )
            : Container(
                padding: const EdgeInsets.all(10.0),
                color: const Color(0x80111010),
                child: Column(
                  children: const [
                    Text(
                        "You don't have any actuator yet\nAdd actuator to control your garden",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center),
                  ],
                ),
              )
      ],
    );
  }

  Widget buildActuator(String number, Actuator actuator) {
    return Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.amber,
        ),
        padding: const EdgeInsets.all(4),
        // color: Colors.orange,
        child: GridTile(
          header: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HeroWidget(
                tag: HeroTag.avatar2(demoActuators[actuator.id! - 1],
                    widget.listThing.indexOf(widget.thing)),
                child: CircleAvatar(
                  radius: 27, //27
                  backgroundColor: Colors.black12,
                  backgroundImage:
                      AssetImage(demoActuators[actuator.id! - 1].urlImg!),
                ),
              ),
              AdvancedSwitch(
                activeChild: const Text('ON', style: TextStyle(fontSize: 25)),
                inactiveChild:
                    const Text('OFF', style: TextStyle(fontSize: 25)),
                borderRadius: BorderRadius.circular(10),
                width: 118,
                //115
                height: 55,
                // controller: demoActuators[actuator.id!-1].controller,
                controller: actuator.controller,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // const SizedBox(width: 5),
            ],
          ),
        ));
  }
}
