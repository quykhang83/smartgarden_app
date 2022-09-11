import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartgarden_app/views/otp/otp_screen.dart';

import '../../components/background-image.dart';
import '../../components/rounded-button.dart';
import '../../components/text-field-input.dart';
import '../../constants.dart';

class ForgotPassword extends StatelessWidget {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: 'assets/images/bg-login.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: kWhite,
              ),
            ),
            title: const Text(
              'Forgot Password',
              style: kBodyText,
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    Container(
                      width: size.width * 0.8,
                      child: const Text(
                        'Enter your phone we will send OTP to reset your password',
                        style: kBodyText,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextInputField(
                      icon: FontAwesomeIcons.phone,
                      hint: 'Phone',
                      textController: phoneController,
                      inputType: TextInputType.phone,
                      inputAction: TextInputAction.done,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RoundedButton(
                      buttonName: 'Send OTP',
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext ctx) =>
                                    OtpScreen()
                            )
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
