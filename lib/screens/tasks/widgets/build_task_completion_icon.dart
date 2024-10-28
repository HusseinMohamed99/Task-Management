part of './../../../core/helpers/export_manager/export_manager.dart';

class BuildTaskCompletionIcon extends StatelessWidget {
  const BuildTaskCompletionIcon(
      {super.key, required this.provider, required this.tasks});
  final SettingsProvider provider;
  final TasksModel tasks;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyDataBase.isDone(tasks);
        provider.refreshApp();
      },
      child: tasks.isDone
          ? Text(
              AppLocalizations.of(context)!.condition,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: ColorManager.greenColor,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                  ),
            )
          : Container(
              margin: const EdgeInsets.all(25).r,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5).r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10).r,
                color: ThemeApp.lightPrimary,
              ),
              child: Icon(
                Icons.check,
                color: ColorManager.whiteColor,
                size: 24.sp,
              ),
            ),
    );
  }
}
