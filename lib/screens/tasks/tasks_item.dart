part of './../../core/helpers/export_manager/export_manager.dart';

class TasksItem extends StatelessWidget {
  final TasksModel tasks;

  const TasksItem(this.tasks, {super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return GestureDetector(
      onTap: () => _navigateToEditTask(context),
      child: Container(
        decoration: BoxDecoration(
          color: settingsProvider.isDarkMode()
              ? ThemeApp.darkBottom
              : ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(18).r,
        ),
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Slidable(
          startActionPane: ActionPane(
            extentRatio: 0.2,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) => _deleteTask(context),
                backgroundColor: ColorManager.redColor,
                foregroundColor: ColorManager.whiteColor,
                icon: Icons.delete_forever,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                ),
              ),
            ],
          ),
          child: BuildTaskContent(
            provider: settingsProvider,
            tasks: tasks,
          ),
        ),
      ),
    );
  }

  void _navigateToEditTask(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTask(tasks),
      ),
    );
  }

  void _deleteTask(BuildContext context) {
    MyDialog.showMessage(
      context,
      AppLocalizations.of(context)!.delete_task,
      posActionTitle: AppLocalizations.of(context)!.yes,
      posAction: () {
        try {
          MyDataBase.deleteTask(tasks);
          MyDialog.showMessage(
            context,
            AppLocalizations.of(context)!.delete_task,
            posActionTitle: AppLocalizations.of(context)!.ok,
          );
        } catch (error) {
          // Optional: Handle error (e.g., show an error message if needed)
        } finally {
          MyDialog.hideDialog(context);
        }
      },
      negActionTitle: AppLocalizations.of(context)!.cancel,
    );
  }
}
