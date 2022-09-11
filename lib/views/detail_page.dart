import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartgarden_app/data/hero_tag.dart';
import 'package:smartgarden_app/models/location.dart';
import 'package:smartgarden_app/views/control_panel.dart';
import 'package:smartgarden_app/views/singup_login/login-screen.dart';
import 'package:smartgarden_app/widget/hero_widget.dart';
import 'package:smartgarden_app/widget/lat_long_widget.dart';
import 'package:smartgarden_app/widget/reviews_widget.dart';

import 'gardens_list.dart';

class DetailPage extends StatelessWidget {
  final Location location;
  final Animation<double> animation;

  DetailPage({
    required this.location,
    required this.animation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0x80111010),
        title: Text(
          location.name,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: Navigator.of(context).pop,
        ),
        actions: [
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.white),
              textTheme: const TextTheme().apply(bodyColor: Colors.white),
            ),
            child: PopupMenuButton<int>(
              color: const Color(0xCC1AB422),
              position: PopupMenuPosition.under,
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text('Add sensors',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text('Settings',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                ),
                const PopupMenuDivider(),
                PopupMenuItem<int>(
                  value: 2,
                  child: Row(
                    children: const [
                      Icon(Icons.logout),
                      SizedBox(width: 8),
                      Text('Log Out',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('token');
                    prefs.remove("user");
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext ctx) => LoginScreen()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: true,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox.expand(
                        child: HeroWidget(
                          tag: HeroTag.image(location.urlImage),
                          child:
                              Image.asset(location.urlImage, fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: LatLongWidget(location: location),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 7,
                    child: Container(
                      color: Colors.blueGrey,
                      child: ReviewsWidget(
                          location: location, animation: animation),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.indigo,
                      child: ControlPanel(location: location),
                    )
                ),
              ],
            ),
          ),
        ],
      ));

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => GardensList()),
          (route) => false,
        );
        break;
      // case 1:
      //   Navigator.of(context).push(
      //     MaterialPageRoute(builder: (context) => (){}),
      //   );
      //   break;
      case 2:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
    }
  }
}
