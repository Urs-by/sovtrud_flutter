import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sovtrud_project/theme.dart'; // Импортируйте вашу тему
import 'package:sovtrud_project/app_data.dart';
import 'package:sovtrud_project/drawer_widget.dart';



void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      theme: themeNotifier.darkTheme ? darkTheme : lightTheme,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(username),
        // Добавляем кнопку для открытия боковой панели
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Открываем боковую панель при нажатии на кнопку
              Scaffold.of(context).openDrawer();
            },
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: Center(

        child: Text('Press the menu icon to open the drawer'),


      ),


    );
  }
}