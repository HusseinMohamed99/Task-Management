import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management/screens/settings/settings_screen.dart';
import 'package:task_management/screens/tasks/tasks_screen.dart';
import 'package:task_management/shared/components/tasks_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
int currentIndex = 0 ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Management',
        style: GoogleFonts.poppins(
          fontSize: 26,
          fontWeight: FontWeight.bold
        ),),
        centerTitle: false,

      ),
      floatingActionButton: FloatingActionButton(
        shape: const StadiumBorder(
          side: BorderSide(color: Colors.white,width: 5)
        ),
        onPressed: ()
        {
          showTasksBottomSheet();
        },
        child: const Icon(Icons.add),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(
          onTap: (index)
          {
            setState(() {
              currentIndex = index;
            });
          },
          currentIndex: currentIndex,
          items:
          const [
            BottomNavigationBarItem(icon: Icon(Icons.list),label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: ''),
          ],
        ),
      ),
      body: screens[currentIndex],
    );
  }
  List<Widget> screens =
  [
    TasksScreen(),
    SettingsScreen(),
  ];

void showTasksBottomSheet() {
  showModalBottomSheet(
      context: context,
      builder: (buildContext) {
        return const TasksBottomSheet();
      });
}

}
















