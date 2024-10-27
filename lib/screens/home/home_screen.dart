part of './../../core/helpers/export_manager/export_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        style: buildTextStyle(fontSize: 20, context: context),
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
      height: MediaQuery.sizeOf(context).height * .06.h,
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
      isScrollControlled: true,
      context: context,
      builder: (buildContext) {
        return const TasksBottomSheet();
      },
    );
  }
}
