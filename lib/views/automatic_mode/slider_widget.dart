import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smartgarden_app/models/sensor.dart';

class SliderWidget extends StatefulWidget {
  final Sensor sensor;

  const SliderWidget({super.key, required this.sensor});

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double value = 35;

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
        width: 280,
        child: Row(
          children: [
            buildSideLabel(min),
            const SizedBox(width: 5),
            Expanded(
              child: Stack(
                children: [
                  Slider(
                    value: value,
                    min: min,
                    max: max,
                    divisions: 20,
                    label: value.round().toString(),
                    onChanged: (value) => setState(() => this.value = value),
                  ),
                  Center(
                    child: Text(
                      '${value.round()}',
                      style: TextStyle(
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
