import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:task_management/screens/desktop/desktop_screen.dart';
import 'package:task_management/screens/home/home_screen.dart';
import 'package:task_management/screens/settings/settings_screen.dart';
import 'package:task_management/screens/tasks/tasks_screen.dart';
import 'package:task_management/shared/providers/settings_provider.dart';
import 'package:task_management/shared/style/theme.dart';

void main() {
  runApp(  ChangeNotifierProvider(
      create: (buildContext) => SettingsProvider(),
      child:Builder(
    builder: (context) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      return const MyApp();
    },
  ),),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (kDebugMode) {
            print(constraints.minWidth.toInt());
          }
          if (constraints.minWidth.toInt() <= 560) {
            return const HomeScreen();
          }
          return const DesktopScreen();
        }),
      theme: ThemeApp.lightTheme,
      darkTheme: ThemeApp.darkTheme,
      themeMode: ThemeMode.light,
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        TasksScreen.routeName: (_) => const TasksScreen(),
        SettingsScreen.routeName: (_) => const SettingsScreen(),
      },
      initialRoute: '/',

    );
  }
}
