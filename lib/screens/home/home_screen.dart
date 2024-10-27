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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.title,
          style: GoogleFonts.poppins(
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
          side: BorderSide(
            color: Colors.white,
            width: 5.w,
          ),
        ),
        onPressed: showTasksBottomSheet,
        child: Icon(
          Icons.add,
          size: 24.sp,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        height: MediaQuery.sizeOf(context).height * .085.h,
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
              icon: Icon(
                Icons.list,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: '',
            ),
          ],
        ),
      ),
      body: screens[currentIndex],
    );
  }

  List<Widget> screens = [
    const TasksScreen(),
    const SettingsScreen(),
  ];

  void showTasksBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (buildContext) {
        return const TasksBottomSheet();
      },
    );
  }
}
