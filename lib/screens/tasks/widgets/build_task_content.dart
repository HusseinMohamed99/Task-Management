part of './../../../core/helpers/export_manager/export_manager.dart';

class BuildTaskContent extends StatelessWidget {
  const BuildTaskContent(
      {super.key, required this.provider, required this.tasks});
  final SettingsProvider provider;
  final TasksModel tasks;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: provider.isDarkMode()
            ? ThemeApp.darkPrimary
            : ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(18).r,
      ),
      child: Row(
        children: [
          BuildTaskStatusIndicator(tasks: tasks),
          Space(width: 25.w, height: 0),
          BuildTaskDetails(tasks: tasks),
          BuildTaskCompletionIcon(provider: provider, tasks: tasks),
        ],
      ),
    );
  }
}
