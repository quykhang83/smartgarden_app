import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartgarden_app/models/location.dart';
import 'package:smartgarden_app/views/detail_page.dart';
import 'package:smartgarden_app/widget/expanded_content_widget.dart';
import 'package:smartgarden_app/widget/image_widget.dart';

import '../controllers/api/my_api.dart';
import '../models/dataStream.dart';
import '../models/sensor.dart';
import '../models/thing.dart';

class ThingWidget extends StatefulWidget {
  final Thing thing;
  final List<Thing> listThing;

  const ThingWidget({
    required this.thing,
    required this.listThing,
    Key? key,
  }) : super(key: key);

  @override
  _ThingWidgetState createState() => _ThingWidgetState();
}

class _ThingWidgetState extends State<ThingWidget> {
  bool isExpanded = false;
  bool isHadData = false;
  List<int> dataSensor = [];

  @override
  void initState() {
    super.initState();
    getDataStreamOfThing().then((value) {
      if (value!.isNotEmpty) {
        isHadData = true;
        dataSensor.clear();
        for (DataStream e in value) {
          print("${e.sensorId}: ${e.name}");
          dataSensor.add(e.sensorId!);
          // idDataStream.add(e.id!);
        }
        // dataSensor.sort();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 250),
            bottom: isExpanded ? 40 : 100,
            width: isExpanded ? size.width * 0.78 : size.width * 0.7,
            height: isExpanded ? size.height * 0.6 : size.height * 0.5,
            child: ExpandedContentWidget(
                thing: widget.thing,
                listThing: widget.listThing,
                dataSensors: dataSensor),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            bottom: isExpanded ? 150 : 100,
            child: GestureDetector(
              onPanUpdate: onPanUpdate,
              onTap: openDetailPage,
              child: ImageWidget(thing: widget.thing),
            ),
          ),
        ],
      ),
    );
  }

  void openDetailPage() {
    if (!isExpanded) {
      /// Tap to expand card
      setState(() {
        isExpanded = true;
      });
      return;
    }

    print('in màn hình + ${widget.thing.id}');
    if (isHadData) {
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: const Interval(0, 0.5),
            );

            return FadeTransition(
              opacity: curvedAnimation,
              child: DetailPage(
                  thing: widget.thing,
                  listThing: widget.listThing,
                  animation: animation,
                  dataSensors: dataSensor),
            );
          },
        ),
      );
    } else {
      print("Some things was wrong!!");
    }
  }

  Future<List<DataStream>?> getDataStreamOfThing() async {
    var res = await CallApi()
        .getData('get/things(${widget.thing.id})/datastreams?top=all');
    var body = json.decode(res.body);
    if (body.toString().isNotEmpty) {
      var thing = body as List<dynamic>;
      var data = thing.map((e) => DataStream.fromJson(e)).toList();
      return data;
    } else {
      return null;
    }
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dy < 0) {
      setState(() {
        isExpanded = true;
      });
    } else if (details.delta.dy > 0) {
      setState(() {
        isExpanded = false;
      });
    }
  }
}
