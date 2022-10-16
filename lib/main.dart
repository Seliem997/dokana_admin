import 'package:dokana_admin_panel/providers/dark_theme_provider.dart';
import 'package:dokana_admin_panel/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'consts/theme_data.dart';
import 'controllers/MenuController.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
    await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MenuController(),
        ),
        ChangeNotifierProvider(
          create: (_) {
            return themeChangeProvider;
          },
        ),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Dokana',
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
