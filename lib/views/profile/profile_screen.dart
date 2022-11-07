import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartgarden_app/views/singup_login/login_screen.dart';

import '../../components/custom_app_bar.dart';
import '../../constants.dart';
import '../../controllers/api/my_api.dart';
import 'components/profile_menu.dart';

class ProfileScreen extends StatefulWidget {
  static String id = "/profile";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUser();
  }

  _getUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      user = localStorage.getString("user");
    });

    // if (user != null) {
    //   return jsonDecode(user);
    //   debugPrint(userData);
    // } else {
    //   debugPrint("no info");
    //   await _getUser();
    // }
  }

  _showMsg(msg) {
    //
    final snackBar = SnackBar(
      backgroundColor: const Color(0xffb41a1a),
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

  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic> userMap = jsonDecode(jsonString);
    // var user = User.fromJson(userMap);
    // Map<String, dynamic> user = _getUser();
    user ??= '{"id":0,"username":"N/A","displayname":"N/A","phone":"N/A","avatar":null,"updated_at":"N/A"}';
    final userData = jsonDecode(user!);
    String displayName = userData['displayname'];

    return Scaffold(
      // extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      // extendBody: true,
      backgroundColor: Colors.orange.shade50,
      appBar: const CustomAppBar(title: 'My Profile'),
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                  height: 200,
                  // color: Colors.orange.shade50,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/images/bg-log3.jpg"),
                    fit: BoxFit.fill,
                  ))),
              Padding(
                padding: const EdgeInsets.only(top: 115),
                child: Container(
                  height: 548,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: const BoxDecoration(
                    // color: Color(0xFFFFBD59),
                    image: DecorationImage(
                      image: AssetImage("assets/images/bg-menu-profile.jpg"),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 250,
                            height: 60,
                            padding: EdgeInsets.only(left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      displayName,
                                      // userData.userName.toString(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      userData['phone'],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                CircleAvatar(
                                  radius: 23,
                                  backgroundColor: Colors.green,
                                  child: CircleAvatar(
                                    radius: 19,
                                    backgroundColor: Color(0xFFF5F6F9),
                                    child: IconButton(
                                      icon: Icon(Icons.edit),
                                      color: Colors.green,
                                      onPressed: () {
                                        _showDialog();
                                        setState(() {
                                          displayName = userData['displayname'];
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      //---------------Menu Frame ---------------//
                      SingleChildScrollView(
                        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            ProfileMenu(
                              text: "My Account",
                              icon: "assets/icons/User Icon.svg",
                              press: () => {},
                            ),
                            ProfileMenu(
                              text: "Notifications",
                              icon: "assets/icons/Bell.svg",
                              press: () {},
                            ),
                            ProfileMenu(
                              text: "Settings",
                              icon: "assets/icons/Settings.svg",
                              press: () {},
                            ),
                            ProfileMenu(
                              text: "Help Center",
                              icon: "assets/icons/Question mark.svg",
                              press: () {},
                            ),
                            ProfileMenu(
                              text: "Log Out",
                              icon: "assets/icons/Log out.svg",
                              press: () async {
                                // var res = await CallApi().deleteToken();
                                // var body = json.decode(res.body);
                                // print(body);
                                // if (body['success']) {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.remove('token');
                                  prefs.remove("user");
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (BuildContext ctx) => LoginScreen()));
                                // } else {
                                //   _showMsg(body['message']);
                                // }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          //-------------Avatar frame------------//
          Padding(
            padding: const EdgeInsets.only(top: 75, left: 20),
            child: SizedBox(
              height: 110,
              width: 110,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.green.shade200,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        userData['avatar'] ??
                        "https://cdn-icons-png.flaticon.com/512/714/714025.png",
                      ),
                      radius: 49,
                      backgroundColor: Colors.green,
                    ),
                  ),
                  Positioned(
                    right: -14,
                    bottom: 0,
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: Colors.white),
                          ),
                          primary: kPrimaryColor,
                          backgroundColor: Color(0xFFF5F6F9),
                        ),
                        onPressed: () {},
                        child: SvgPicture.asset("assets/icons/Camera Icon.svg",
                            color: kPrimaryColor),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //--------- It's not work / can't change nick name -----------//
  void _showDialog() async {
    TextEditingController _changeNameTextController = TextEditingController();
    await showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Change Nickname",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    fontFamily: "Muli-BoldItalic")),
            contentPadding: const EdgeInsets.all(20.0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: TextField(
              autofocus: true,
              decoration: const InputDecoration(
                iconColor: Colors.green,
                labelText: 'Type your nick name',
                floatingLabelStyle: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: 22),
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                fillColor: Colors.green,
                focusColor: Colors.green,
                hintText: 'Ex: Quy Khang',
              ),
              controller: _changeNameTextController,
            ),
            actions: <Widget>[
              TextButton(
                  child: const Text('CANCEL',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: const Text('SUBMIT',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                  onPressed: () async {
                    SharedPreferences localStorage = await SharedPreferences.getInstance();
                    // var user = localStorage.getString("user");
                    final userData = jsonDecode(user.toString());
                    await localStorage.setString(userData['displayname'], _changeNameTextController.text);
                    print(userData['displayname']);
                    setState(() {
                      user = localStorage.getString("user");
                    });
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }
}
