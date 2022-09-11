import 'package:flutter/material.dart';

import 'components/body.dart';

class LoginSuccessScreen extends StatelessWidget {
  static String id = "/login_success";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: SizedBox(),
        title: const Text(
          "Login Success",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
