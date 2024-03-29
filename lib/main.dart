import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sovtrud_project/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'package:sovtrud_project/app_data.dart';
import 'package:sovtrud_project/drawer_widget.dart';
import 'package:sovtrud_project/task_screen.dart';




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
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // Английский (США)
        const Locale('ru', 'RU'), // Русский (Россия)
        // Добавьте другие языки здесь
      ],
      locale: const Locale('ru', 'RU'),
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
      body: TaskScreen(),
    );
  }
}