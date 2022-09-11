import 'package:flutter/material.dart';

import '../components/menu_widget.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Test Page'),
        leading: MenuWidget(),
      ),
    );
  }
}
