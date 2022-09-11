import 'package:flutter/widgets.dart';
import 'package:smartgarden_app/controllers/auth/auth_page.dart';
import 'package:smartgarden_app/views/login_success/login_success_screen.dart';
import 'package:smartgarden_app/views/main_board.dart';
import 'package:smartgarden_app/views/otp/otp_screen.dart';
import 'package:smartgarden_app/views/profile/profile_screen.dart';
import 'package:smartgarden_app/views/singup_login/create-new-account.dart';
import 'package:smartgarden_app/views/singup_login/login-screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  CreateNewAccount.id: (context) => CreateNewAccount(),
  LoginScreen.id: (context) => LoginScreen(),
  AuthPage.id: (context) => AuthPage(),
  MainBoard.id: (context) => MainBoard(),
  OtpScreen.id: (context) => OtpScreen(),
  LoginSuccessScreen.id: (context) => LoginSuccessScreen(),
  ProfileScreen.id: (context) => ProfileScreen(),
};
