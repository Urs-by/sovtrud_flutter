import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sovtrud_project/theme.dart';
import 'package:sovtrud_project/app_data.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeNotifier = Provider.of<ThemeNotifier>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(draver_header),
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
            ),
          ),
          ListTile(
            title: Text(draver_change_theme),
            onTap: () {
              themeNotifier.toggleTheme();
            },
          ),
          ListTile(
            title: Text(draver_turn),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}