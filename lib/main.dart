import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/screens/desktop/desktop_screen.dart';
import 'package:task_management/screens/home/home_screen.dart';
import 'package:task_management/shared/providers/settings_provider.dart';
import 'package:task_management/shared/style/theme.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (buildContext) => SettingsProvider(),
      child: Builder(
        builder: (context) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          return MyApp();
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  late SettingsProvider settingsProvider;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of<SettingsProvider>(context);
    getValueFromPref();
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child)
      {
        return MaterialApp(

          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(settingsProvider.currentLanguage),
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
          themeMode: settingsProvider.currentTheme,
          routes: {
            HomeScreen.routeName: (_) => const HomeScreen(),
          },
          initialRoute: '/',
        );
      },
    );
  }

  getValueFromPref() async {
    final pref = await SharedPreferences.getInstance();
    settingsProvider.changeLanguage(pref.getString("Lang") ?? "Light");

    if (pref.getString("Theme") == "Light") {
      settingsProvider.changeTheme(ThemeMode.light);
    } else if (pref.getString("Theme") == "Dark") {
      settingsProvider.changeTheme(ThemeMode.dark);
    }
  }
}
