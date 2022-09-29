import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartgarden_app/models/menu_item.dart';
import 'package:smartgarden_app/views/gardens_list.dart';
import 'package:smartgarden_app/views/home.dart';
import 'package:smartgarden_app/views/menu_page.dart';
import 'package:smartgarden_app/views/profile/profile_screen.dart';
import 'package:smartgarden_app/views/test_page.dart';

import '../controllers/api/my_api.dart';

class MainBoard extends StatefulWidget {
  static String id = "/homepage";
  const MainBoard({Key? key}) : super(key: key);

  @override
  State<MainBoard> createState() => _MainBoardState();
}

class _MainBoardState extends State<MainBoard> {
  MyMenuItem currentItem = MenuItems.home;
  @override
  void initState() {
    // TODO: implement initState
    _getData();
    super.initState();
  }

  _getData() async {

    var res = await CallApi().getData('getThings');
    var body = json.decode(res.body);
    print(body);
    if (body['success']) {

      print('có data');

    } else {
      print(body['message']);
    }
  }



  @override
  Widget build(BuildContext context) => ZoomDrawer(
    // style: DrawerStyle.style2,
    borderRadius: 50,
    angle: -8,
    slideWidth: MediaQuery.of(context).size.width * 0.6,
    showShadow: true,
    drawerShadowsBackgroundColor: Colors.orangeAccent,
    menuBackgroundColor: Colors.indigo,
    menuScreenOverlayColor: Colors.black26,
    menuScreenWidth: 500,
    mainScreen: getScreen(),
    menuScreen: Builder(
      builder: (context) => MenuPage(
        currentItem: currentItem,
        onSelectedItem: (item) {
          setState(() => currentItem = item);

          ZoomDrawer.of(context)!.close();
        },
      ),
    ),
  );

  Widget getScreen(){
    switch (currentItem){
      case MenuItems.home: return GardensList();
      case MenuItems.promos: return TestPage();
      case MenuItems.notifications: return GardensList();
      case MenuItems.help: return TestPage();
      case MenuItems.aboutUs: return TestPage();
      case MenuItems.profile: return ProfileScreen();
      default: return HomePage();
    }
  }
}
