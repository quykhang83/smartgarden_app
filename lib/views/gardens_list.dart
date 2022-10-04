import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartgarden_app/components/custom_app_bar.dart';
import 'package:smartgarden_app/widget/locations_widget.dart';

import '../components/background-image.dart';
import '../controllers/api/my_api.dart';
import '../models/thing.dart';

class GardensList extends StatefulWidget {
  @override
  State<GardensList> createState() => _GardensListState();
}

class _GardensListState extends State<GardensList> {

  String token = '';
  late Map<String, String> header ;
  List<Thing> data = [];
  late Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    getData().then((value) {
      setState((){
        data.addAll(value!);

      });
    });
   // timer = Timer.periodic(const Duration(seconds: 10), (Timer t) => print('object'));
    super.initState();
  }

  Future<List<Thing>?> getData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token')!;
    header =  {
      'Content-type' : 'application/json',
      'Accept' : 'application/json',
      'Charset': 'utf-8',
      'token': token,
    };
    var res = await CallApi().getDataHeader('getThings', header);
    var body = json.decode(res.body);
    // print(body);
    if (body['success']) {
      var thing = body['data'] as List<dynamic>;

      var data = thing.map((e) => Thing.fromJson(e)).toList();
      return data;
    } else {
      return null;
      print(body['message']);
    }
  }



  @override
  Widget build(BuildContext context) => Scaffold(
        // extendBodyBehindAppBar: true,
        // backgroundColor: Colors.blueGrey,
        appBar: const CustomAppBar(title: 'YOUR GARDEN'),
        body: Stack(
          children: [
            const BackgroundImage(
              image: 'assets/images/bg-garden.jpg',
            ),
          ThingsWidget(thing: data),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {},
        ),
        // bottomNavigationBar: buildBottomNavigation(),
      );

  Widget buildBottomNavigation() => BottomNavigationBar(
        elevation: 0,
        unselectedItemColor: Colors.white54,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.pin_drop_outlined),
            label: 'Add one',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_location),
            label: '',
          ),
        ],
      );
}
