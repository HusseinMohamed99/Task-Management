part of './core/helpers/export_manager/export_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
      child: const TaskManagerApp(),
    ),
  );
}

Future<void> _initializeApp() async {
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kReleaseMode) {
    // Pass all uncaught "fatal" errors from the framework to Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  if (kReleaseMode) {
    await requestReview();
  }
  if (kDebugMode) {
    await Upgrader.clearSavedSettings();
  }
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    _loadSettings(settingsProvider);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
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
          theme: ThemeApp.lightTheme,
          darkTheme: ThemeApp.darkTheme,
          themeMode: settingsProvider.currentTheme,
          routes: {
            HomeScreen.routeName: (_) => const HomeScreen(),
          },
          initialRoute: HomeScreen.routeName,
        );
      },
    );
  }
}

Future<void> _loadSettings(SettingsProvider settingsProvider) async {
  final prefs = await SharedPreferences.getInstance();
  final language = prefs.getString('Lang') ?? 'en';
  final theme = prefs.getString('Theme');

  settingsProvider.changeLanguage(language);

  if (theme == 'Light') {
    settingsProvider.changeTheme(ThemeMode.light);
  } else if (theme == 'Dark') {
    settingsProvider.changeTheme(ThemeMode.dark);
  }
}

Future<void> requestReview() async {
  final InAppReview inAppReview = InAppReview.instance;

  if (await inAppReview.isAvailable()) {
    await inAppReview.requestReview();
  } else {
    goToApplicationOnPlayStore();
  }
}

goToApplicationOnPlayStore() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String url = '';
  String packageName = packageInfo.packageName;
  if (Platform.isAndroid) {
    url = 'https://play.google.com/store/apps/details?id=$packageName';
  } else if (!await launchUrl(Uri.parse(url),
      mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}
