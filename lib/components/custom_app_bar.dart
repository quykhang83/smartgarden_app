import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartgarden_app/views/gardens_list.dart';

import '../views/singup_login/login-screen.dart';
import 'menu_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  // AppBar().preferredSize.height provide us the height that apply on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      // backgroundColor: Color(0x80111010),
      title: Center(
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w500),
          textAlign: TextAlign.center
        ),
      ),
      leading: MenuWidget(),
      actions: [
        Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.white),
            textTheme: TextTheme().apply(bodyColor: Colors.white),
          ),
          child: PopupMenuButton<int>(
            color: Color(0xFF1AB422),
            position: PopupMenuPosition.under,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text('Gardens List'),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Settings'),
              ),
              PopupMenuDivider(),
              PopupMenuItem<int>(
                value: 2,
                child: Row(
                  children: const [
                    Icon(Icons.logout),
                    SizedBox(width: 8),
                    Text('Sign Out'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> onSelected(BuildContext context, int item) async {
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
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('token');
        prefs.remove("user");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext ctx) => LoginScreen()));
    }
  }
}
