import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartgarden_app/views/otp/otp_screen.dart';
import 'package:smartgarden_app/views/singup_login/login_screen.dart';

import '../../components/background_image.dart';
import '../../components/password_input.dart';
import '../../components/rounded_button.dart';
import '../../components/text_field_input.dart';
import '../../constants.dart';
import '../../controllers/api/my_api.dart';
import '../home.dart';

class CreateNewAccount extends StatefulWidget {
  static String id = "/newsignup";

  const CreateNewAccount({Key? key}) : super(key: key);

  @override
  _CreateNewAccountState createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  // static String id = "/signin";
  TextEditingController passController = TextEditingController();
  TextEditingController repassController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _register() async {
    var data = {
      'displayname': nameController.text,
      'username': usernameController.text,
      'password': passController.text,
      'phone': phoneController.text,
    };

    debugPrint(nameController.text);
    debugPrint(phoneController.text);
    debugPrint(usernameController.text);
    debugPrint(passController.text);
    debugPrint(repassController.text);

    var res = await CallApi().postData(data, 'register');
    var body = json.decode(res.body);
    print(body);
    if (body['success']) {
      //SharedPreferences localStorage = await SharedPreferences.getInstance();
      //localStorage.setString('token', body['token']);
      //localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OtpScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: 'assets/images/bg-log4.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 0.18,
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
                SizedBox(
                  height: size.width * 0.02,
                ),
                Column(
                  children: [
                    TextInputField(
                      icon: FontAwesomeIcons.userTag,
                      hint: 'Fullname',
                      textController: nameController,
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                    ),
                    TextInputField(
                      icon: FontAwesomeIcons.phone,
                      hint: 'Phone',
                      textController: phoneController,
                      inputType: TextInputType.phone,
                      inputAction: TextInputAction.next,
                    ),
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
                      inputAction: TextInputAction.next,
                    ),
                    PasswordInput(
                      icon: FontAwesomeIcons.lock,
                      hint: 'Confirm Password',
                      textController: repassController,
                      inputAction: TextInputAction.done,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    // GestureDetector(
                    //     onTap: () {
                    //       _register();
                    //     },
                    //     child: const RoundedButton(
                    //       buttonName: 'Register',
                    //     ),
                    // ),
                    RoundedButton(
                      buttonName: 'Register',
                      press: _register,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: kBodyText,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext ctx) =>
                                        LoginScreen()));
                          },
                          child: Text(
                            ' Login',
                            style: kBodyText.copyWith(
                                color: kPrimaryColor, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
