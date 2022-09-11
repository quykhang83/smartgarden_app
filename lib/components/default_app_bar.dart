import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;

  const DefaultAppBar({Key? key, required this.title}) : super(key: key);

  @override
  // AppBar().preferredSize.height provide us the height that apply on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: Navigator.of(context).pop,
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
      ),
      centerTitle: true,
    );
  }
}
