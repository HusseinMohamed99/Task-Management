part of './../../core/helpers/export_manager/export_manager.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});
  static const String routeName = 'TasksScreen';

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Column(
      children: [
        BuildHeader(
            settingsProvider: settingsProvider,
            selectedDate: selectedDate,
            onDateSelected: (date) {
              setState(() {
                selectedDate = date;
              });
            }),
        Expanded(
          child: BuildTaskList(selectedDate: selectedDate),
        ),
      ],
    );
  }
}
