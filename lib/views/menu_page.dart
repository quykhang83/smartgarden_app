import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartgarden_app/models/menu_item.dart';

class MenuItems {
  static const home = MyMenuItem('Home', Icons.home_rounded);
  static const promos = MyMenuItem('Promos', Icons.card_giftcard);
  static const notifications = MyMenuItem('Notifications', Icons.notifications_rounded);
  static const help = MyMenuItem('Help', Icons.help_rounded);
  static const aboutUs = MyMenuItem('About Us', Icons.info_outline_rounded);
  static const profile = MyMenuItem('Profile', Icons.account_box_rounded);

  static const all = <MyMenuItem>[
    home,
    promos,
    notifications,
    help,
    aboutUs,
    profile,
  ];
}

class MenuPage extends StatelessWidget {
  final MyMenuItem currentItem;
  final ValueChanged<MyMenuItem> onSelectedItem;

  const MenuPage({
    Key? key,
    required this.currentItem,
    required this.onSelectedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Theme(
    data: ThemeData.dark(),
    child: Scaffold(
      backgroundColor: Colors.indigo,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Spacer(),
            ...MenuItems.all.map(buildMenuItem).toList(),
            Spacer(flex: 2),
          ],
        ),
      ),
    ),
  );

  Widget buildMenuItem(MyMenuItem item) => ListTileTheme(
    selectedColor: Colors.white,
    child: ListTile(
      selectedTileColor: Colors.black26,
      selected: currentItem == item,
      minLeadingWidth: 20,
      leading: Icon(item.icon),
      title: Text(item.title),
      onTap: () => onSelectedItem(item),
    ),
  );
}
