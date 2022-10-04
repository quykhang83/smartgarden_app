import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:smartgarden_app/models/actuator.dart';

import '../data/hero_tag.dart';
import '../data/locations.dart';
import '../models/location.dart';
import '../models/thing.dart';
import '../widget/hero_widget.dart';

class ControlPanel extends StatefulWidget {
  final Location location;

  const ControlPanel({
    Key? key,
    required this.location
  }) : super(key: key);

  @override
  State<ControlPanel> createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel>
    with TickerProviderStateMixin {
  // 0. Quantity of controller
  final numbers = List.generate(2, (index) => '$index');
  final scrollController = ScrollController();

  // 1. Create a controller in the state of the StatefulWidget
  // final _controller = ValueNotifier<bool>(false);

  // 2. In case, you want to call setState on switch changes.
  // 2.1. Add event listener, for example in the initState() method.
  // ...
  bool _checked = false;

  List<Actuator> actuators = demoActuators;

  // ...
  @override
  void initState() {
    super.initState();

    //--------------------Fetch controller data----------------------//
    List<bool> receivedController = [true, false];

    for(int i=0; i<actuators.length; i++){
      actuators[i].controller.value = receivedController[i];

      actuators[i].controller.addListener(() {
        setState(() {
          if (actuators[i].controller.value) {
            _checked = true;
          } else {
            _checked = false;
          }
          print("${actuators[i].name}: $_checked");
        });
      });
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 0.34,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(4),
      controller: scrollController,
      itemCount: numbers.length,
      itemBuilder: (context, index) {
        final actuator = widget.location.actuators[index];
        final item = numbers[index];

        return buildActuator(item, actuator);
      },
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeroWidget(
                tag: HeroTag.avatar2(actuator, locations.indexOf(widget.location)),
                child: CircleAvatar(
                  radius: 27,
                  backgroundColor: Colors.black12,
                  backgroundImage: AssetImage(actuator.urlImg),
                ),
              ),
              // Text(
              //   actuators[int.parse(number)].name,
              //   textAlign: TextAlign.center,
              //   style:
              //   const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              // ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(width: 5),
              AdvancedSwitch(
                activeChild: const Text('ON', style: TextStyle(fontSize: 25)),
                inactiveChild: const Text('OFF', style: TextStyle(fontSize: 25)),
                borderRadius: BorderRadius.circular(10),
                width: 115,
                height: 55,
                controller: actuators[int.parse(number)].controller,
              ),
            ],
          ),
        )
    );
  }
}
