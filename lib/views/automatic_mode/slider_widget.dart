import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smartgarden_app/models/sensor.dart';

import '../../controllers/api/my_api.dart';
import 'automode_panel.dart';

class SliderWidget extends StatefulWidget {
  final Sensor sensor;
  final int index;
  final double initVal;

  const SliderWidget({super.key, required this.sensor, required this.index, required this.initVal});

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double value = 0;

  @override
  void initState() {
    super.initState();
    value = AutoModePanel.of(context)!.autoValues[widget.index];
    print("Slider ${widget.index}: $value");
  }

  @override
  Widget build(BuildContext context) {
    final double min = widget.sensor.initVale;
    final double max = widget.sensor.maximumValue;
    // final double max = 10000;

    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 20,
        activeTrackColor: widget.sensor.color,
        inactiveTrackColor: Colors.grey[400],
        thumbColor: widget.sensor.color,

        // thumbShape: SliderComponentShape.noOverlay,
        overlayShape: SliderComponentShape.noOverlay,
        // valueIndicatorShape: SliderComponentShape.noOverlay,

        // trackShape: RectangularSliderTrackShape(),

        /// ticks in between
        activeTickMarkColor: Colors.transparent,
        inactiveTickMarkColor: Colors.transparent,
      ),
      child: SizedBox(
        width: 240,
        child: Row(
          children: [
            buildSideLabel(min),
            const SizedBox(width: 5),
            Expanded(
              child: Stack(
                children: [
                  Slider(
                    value: AutoModePanel.of(context)!.autoValues[widget.index],
                    min: min,
                    max: max,
                    divisions: 100,
                    label: value.round().toString(),
                    onChanged: (value) {
                      setState(() => this.value = value);
                      AutoModePanel.of(context)?.autoValues[widget.index] = value;
                    },
                  ),
                  Center(
                    child: Text(
                      '${(value.round()==0) ? AutoModePanel.of(context)!.autoValues[widget.index].round() : value.round()}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5),
            buildSideLabel(max),
          ],
        ),
      ),
    );
  }

  Widget buildSideLabel(double value) => Text(
        value.round().toString(),
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      );
}
