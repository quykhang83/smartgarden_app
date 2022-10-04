import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smartgarden_app/models/location.dart';
import 'package:smartgarden_app/views/detail_page.dart';
import 'package:smartgarden_app/widget/expanded_content_widget.dart';
import 'package:smartgarden_app/widget/image_widget.dart';

import '../models/thing.dart';

class ThingWidget extends StatefulWidget {
  final Thing thing;

  const ThingWidget({
    required this.thing,
    Key? key,
  }) : super(key: key);

  @override
  _ThingWidgetState createState() => _ThingWidgetState();
}

class _ThingWidgetState extends State<ThingWidget> {
  bool isExpanded = false;

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
            child: ExpandedContentWidget(thing: widget.thing),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 250),
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
      setState(() => isExpanded = true);
      return;
    }
print('in màn hình ');
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
            child: DetailPage(thing: widget.thing, animation: animation),
          );
        },
      ),
    );
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
