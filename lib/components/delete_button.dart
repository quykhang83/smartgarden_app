import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // height: getProportionateScreenHeight(56),
      height: (56 / 812.0) * MediaQuery.of(context).size.height,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white, shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.red,
        ),
        onPressed: press as void Function()?,

        child: Text(
          text!,
          style: TextStyle(
            // fontSize: getProportionateScreenWidth(18),
            fontSize: (18 / 375.0) * MediaQuery.of(context).size.width,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
