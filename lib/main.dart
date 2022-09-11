import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartgarden_app/controllers/auth/auth_page.dart';
import 'package:smartgarden_app/routes.dart';
import 'package:smartgarden_app/views/demo_fetch_api.dart';
import 'package:smartgarden_app/views/main_board.dart';
import 'package:smartgarden_app/views/otp/otp_screen.dart';
import 'package:smartgarden_app/views/singup_login/create-new-account.dart';
import 'package:smartgarden_app/views/singup_login/login-screen.dart';

import 'views/gardens_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Smart Garden App',
      theme: ThemeData(
        textTheme:
        GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: AuthPage.id,
      routes: routes,
    );
  }
}

