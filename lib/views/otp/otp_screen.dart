import 'package:flutter/material.dart';
import 'package:smartgarden_app/size_config.dart';

import '../../components/default_app_bar.dart';
import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  static String id = "/otp";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: const DefaultAppBar(title: "OTP Verification"),
      body: Body(),
    );
  }
}
