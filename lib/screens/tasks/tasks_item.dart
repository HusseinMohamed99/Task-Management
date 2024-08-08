import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_management/model/task_model.dart';
import 'package:task_management/screens/tasks/edit_task.dart';
import 'package:task_management/shared/adaptive/dialog.dart';
import 'package:task_management/shared/components/size_box.dart';
import 'package:task_management/shared/database/my_database.dart';
import 'package:task_management/shared/providers/settings_provider.dart';
import 'package:task_management/shared/style/theme.dart';

class TasksItem extends StatelessWidget {
  final TasksModel tasks;

  const TasksItem(this.tasks, {super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditTask(tasks),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(18).r,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8).r,
        child: Slidable(
          startActionPane: ActionPane(
            extentRatio: 0.2,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) {
                  deleteTask(context);
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete_forever,
                label: AppLocalizations.of(context)!.delete,
                borderRadius: const BorderRadius.all(
                  Radius.circular(18),
                ).r,
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(12).r,
            decoration: BoxDecoration(
              color: provider.isDarkMode()
                  ? const Color(0xff141922)
                  : Colors.white,
              borderRadius: BorderRadius.circular(18).r,
            ),
            child: Row(
              children: [
                Container(
                  height: 80.h,
                  width: 5.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18).r,
                    color: tasks.isDone ? Colors.green : Colors.blue,
                  ),
                ),
                Space(width: 25.w, height: 0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        tasks.title,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                color:
                                    tasks.isDone ? Colors.green : Colors.blue,
                              ),
                        ),
                      ),
                      Space(width: 0, height: 10.h),
                      Text(
                        tasks.description,
                        style: GoogleFonts.roboto(
                          textStyle: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    MyDataBase.isDone(tasks);
                    provider.refreshApp();
                  },
                  child: tasks.isDone
                      ? Text(
                          AppLocalizations.of(context)!.condition,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                color: Colors.green,
                                fontSize: 25.sp,
                                fontWeight: FontWeight.bold,
                              ),
                        )
                      : Container(
                          margin: const EdgeInsets.all(25).r,
                          padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5)
                              .r,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ThemeApp.lightPrimary,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteTask(BuildContext context) {
    MyDialog.showMessage(
      context,
      AppLocalizations.of(context)!.delete_task,
      posActionTitle: AppLocalizations.of(context)!.yes,
      posAction: () {
        MyDataBase.deleteTask(tasks).then((value) {
          MyDialog.showMessage(context, 'Task Deleted Successfully',
              posActionTitle: 'Ok');
          MyDialog.hideDialog(context);
        }).catchError((error) {
          MyDialog.hideDialog(context);
        });
      },
      negActionTitle: AppLocalizations.of(context)!.cancel,
    );
  }
}
