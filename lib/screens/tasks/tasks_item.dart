part of './../../core/helpers/export_manager/export_manager.dart';

class TasksItem extends StatelessWidget {
  final TasksModel tasks;

  const TasksItem(this.tasks, {super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return InkWell(
      onTap: () => _navigateToEditTask(context),
      child: Container(
        decoration: BoxDecoration(
          color: ThemeApp.lightPrimary,
          borderRadius: BorderRadius.circular(18).r,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8).r,
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
                label: AppLocalizations.of(context)!.delete,
                borderRadius: BorderRadius.circular(18).r,
              ),
            ],
          ),
          child: _buildTaskContent(context, settingsProvider),
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

  Widget _buildTaskContent(BuildContext context, SettingsProvider provider) {
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
          _buildTaskStatusIndicator(),
          Space(
            width: 25.w,
            height: 0
          ),
          _buildTaskDetails(context),
          _buildTaskCompletionIcon(context, provider),
        ],
      ),
    );
  }

  Widget _buildTaskStatusIndicator() {
    return Container(
      height: 60.h,
      width: 5.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18).r,
        color: tasks.isDone ? ColorManager.greenColor : ColorManager.blueColor,
      ),
    );
  }

  Widget _buildTaskDetails(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            tasks.title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: tasks.isDone
                  ? ColorManager.greenColor
                  : ColorManager.blueColor,
              textStyle: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Space(
            height: 6.h,
            width: 0
          ),
          Text(
            tasks.description,
            style: GoogleFonts.roboto(
              textStyle: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCompletionIcon(
      BuildContext context, SettingsProvider provider) {
    return InkWell(
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

  void _deleteTask(BuildContext context) {
    MyDialog.showMessage(
      context,
      AppLocalizations.of(context)!.delete_task,
      posActionTitle: AppLocalizations.of(context)!.yes,
      posAction: () {
        MyDataBase.deleteTask(tasks).then((value) {
          MyDialog.showMessage(
              context, AppLocalizations.of(context)!.delete_task,
              posActionTitle: AppLocalizations.of(context)!.ok);
          MyDialog.hideDialog(context);
        },).catchError((error) {
          MyDialog.hideDialog(context);
        },);
      },
      negActionTitle: AppLocalizations.of(context)!.cancel,
    );
  }
}
