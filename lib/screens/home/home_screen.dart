part of './../../core/helpers/export_manager/export_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkForUpdate(context);
    });
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: _buildAppBar(context),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(settingsProvider),
      body: screens[currentIndex],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        AppLocalizations.of(context)!.title,
        style: buildTextStyle(
            fontSize: 20,
            context: context,
            settingsProvider: Provider.of<SettingsProvider>(context)),
      ),
      centerTitle: false,
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      shape: StadiumBorder(
        side: BorderSide(
          color: ColorManager.whiteColor,
          width: 5.w,
        ),
      ),
      onPressed: showTasksBottomSheet,
      child: Icon(
        Icons.add,
        size: 24.sp,
      ),
    );
  }

  BottomAppBar _buildBottomNavigationBar(SettingsProvider settingsProvider) {
    return BottomAppBar(
      color: settingsProvider.isDarkMode()
          ? ThemeApp.darkBottom
          : ColorManager.whiteColor,
      padding: EdgeInsets.zero,
      shape: const CircularNotchedRectangle(),
      notchMargin: 10.r,
      child: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
        ],
      ),
    );
  }

  List<Widget> screens = const [
    TasksScreen(),
    SettingsScreen(),
  ];

  void showTasksBottomSheet() {
    showModalBottomSheet(
      // allows it to take up more space when the keyboard opens
      isScrollControlled: true,
      context: context,
      builder: (buildContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: const TasksBottomSheet(),
        );
      },
    );
  }
}

Future<void> checkForUpdate(BuildContext context) async {
  final remoteConfig = FirebaseRemoteConfig.instance;

  // Set the Remote Config fetch settings
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 10),
    minimumFetchInterval: const Duration(hours: 1),
  ));

  try {
    // Fetch and activate the remote config
    await remoteConfig.fetchAndActivate();

    // Get the remote version from Remote Config
    final latestVersion = remoteConfig.getString('latest_version');

    // Log the latest version to check if it's fetched correctly
    print('Latest version fetched: $latestVersion');

    // Get the current app version
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;

    // Log the current version
    print('Current app version: $currentVersion');

    // Check if the app needs to be updated
    if (_isVersionOlder(currentVersion, latestVersion)) {
      await showUpdateDialog(context);
    }
  } catch (e) {
    print('Error fetching remote config: $e');
  }
}

bool _isVersionOlder(String remoteVersion, String currentVersion) {
  // Split the versions and parse each part as an integer
  List<int> remoteParts =
      remoteVersion.split('.').map((part) => int.tryParse(part) ?? 0).toList();
  List<int> currentParts =
      currentVersion.split('.').map((part) => int.tryParse(part) ?? 0).toList();

  for (int i = 0; i < remoteParts.length; i++) {
    if (remoteParts[i] > currentParts[i]) {
      return true; // Remote version is newer
    } else if (remoteParts[i] < currentParts[i]) {
      return false; // Current version is up-to-date
    }
  }
  return false; // Versions are the same
}

Future<void> showUpdateDialog(BuildContext context) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String packageName = packageInfo.packageName;
  // Ensure the dialog is shown after the frame is rendered
  WidgetsBinding.instance.addPostFrameCallback(
    (_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'تحديث جديد متاح',
              style: buildTextStyle(
                  context: context,
                  fontSize: 15,
                  settingsProvider: Provider.of<SettingsProvider>(context)),
            ),
            content: const Text(
                'يوجد إصدار جديد من التطبيق. يُفضل تحديث التطبيق للحصول على أحدث الميزات.'),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'لاحقًا',
                  style: buildTextStyle(
                      context: context,
                      fontSize: 15,
                      settingsProvider: Provider.of<SettingsProvider>(context)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  'تحديث الآن',
                  style: buildTextStyle(
                      context: context,
                      fontSize: 15,
                      settingsProvider: Provider.of<SettingsProvider>(context)),
                ),
                onPressed: () {
                  _launchURL(
                      'https://play.google.com/store/apps/details?id=$packageName');
                },
              ),
            ],
          );
        },
      );
    },
  );
}

Future<void> _launchURL(String url) async {
  !await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  {
    throw Exception('لا يمكن فتح الرابط $url');
  }
}
