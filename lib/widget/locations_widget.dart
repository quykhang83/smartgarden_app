import 'package:flutter/material.dart';

import '../models/thing.dart';
import 'location_widget.dart';

class ThingsWidget extends StatefulWidget {
  final List<Thing> thing;

  const ThingsWidget({
    required this.thing,
    Key? key,
  }) : super(key: key);

  @override
  _ThingsWidgetState createState() => _ThingsWidgetState();
}

class _ThingsWidgetState extends State<ThingsWidget> {
  final pageController = PageController(viewportFraction: 0.8);
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 30),
          Text(
            (widget.thing.isNotEmpty)
              ? '${pageIndex + 1}/${widget.thing.length}'
              : '0/0',
            style: const TextStyle(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: widget.thing.length,
              itemBuilder: (context, index) {
                print(widget.thing[index].name);
                return ThingWidget(thing: widget.thing[index], listThing: widget.thing);
              },
              onPageChanged: (index) => setState(() => pageIndex = index),
            ),
          ),
          SizedBox(height: 60)
        ],
      );
}
