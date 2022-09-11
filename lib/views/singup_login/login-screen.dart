import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartgarden_app/views/singup_login/create-new-account.dart';
import 'package:smartgarden_app/views/singup_login/forgot-password.dart';

import '../../components/background-image.dart';
import '../../components/password-input.dart';
import '../../components/rounded-button.dart';
import '../../components/text-field-input.dart';
import '../../constants.dart';
import '../../controllers/api/my_api.dart';
import '../main_board.dart';

class LoginScreen extends StatefulWidget {
  static String id = "/login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _showMsg(msg) {
    //
    final snackBar = SnackBar(
      backgroundColor: Color(0xffb41a1a),
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        textColor: Colors.white,
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _login() async {
    var data = {
      'username': usernameController.text,
      'password': passController.text,
    };

    debugPrint(usernameController.text);
    debugPrint(passController.text);

    var res = await CallApi().postData(data, 'login');
    var body = json.decode(res.body);
    print(body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));
      var user = localStorage.getString('user');
      print(user);
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => MainBoard()));
    } else {
      _showMsg(body['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        const BackgroundImage(
          image: 'assets/images/bg-login2.jpg',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 0.28,
                ),
                Stack(
                  children: [
                    Center(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: CircleAvatar(
                            radius: size.width * 0.2,
                            backgroundColor: Colors.grey[400]!.withOpacity(
                              0.4,
                            ),
                            backgroundImage:
                                AssetImage("assets/images/logo.JPG"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Center(
                  child: Text(
                    'Smart\nGarden',
                    softWrap: true,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextInputField(
                      icon: FontAwesomeIcons.user,
                      hint: 'Username',
                      textController: usernameController,
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                    ),
                    PasswordInput(
                      icon: FontAwesomeIcons.lock,
                      hint: 'Password',
                      textController: passController,
                      inputAction: TextInputAction.done,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext ctx) =>
                                    ForgotPassword()));
                      },
                      child: const Text(
                        'Forgot Password',
                        style: kBodyText,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    RoundedButton(
                      buttonName: 'Login',
                      press: _login,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext ctx) => CreateNewAccount()));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: kWhite))),
                    child: const Text(
                      'Create New Account',
                      style: kBodyText,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
