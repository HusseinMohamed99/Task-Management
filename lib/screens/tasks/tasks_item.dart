import 'package:flutter/material.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TasksItem extends StatelessWidget {
  TasksModel tasks;
  TasksItem(this.tasks, {super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EditTask(tasks)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(18),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                borderRadius: const BorderRadius.all(Radius.circular(18),),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: provider.isDarkMode() ? const Color(0xff141922) : Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: tasks.isDone ? Colors.green : Colors.blue,
                  ),
                ),
                const Space(width: 25, height: 0),
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
                              .headline6
                              ?.copyWith(
                                color:
                                    tasks.isDone ? Colors.green : Colors.blue,
                              ),
                        ),
                      ),
                      const Space(width: 0, height: 10),
                      Text(
                        tasks.description,
                        style: GoogleFonts.roboto(
                            textStyle: Theme.of(context).textTheme.subtitle2),
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
                              .headline2!
                              .copyWith(
                                  color: Colors.green,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold))
                      : Container(
                          margin: const EdgeInsets.all(25),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ThemeApp.lightPrimary,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
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
        MyDialog.showLoadingDialog(context, AppLocalizations.of(context)!.loading);
        MyDataBase.deleteTask(tasks).then((value) {
          MyDialog.hideDialog(context);
          // MyDialog.showMessage(context, 'Task Deleted Successfully',posActionTitle: 'Ok');
        }).catchError((error) {
          MyDialog.hideDialog(context);
        });
      },
      negActionTitle: AppLocalizations.of(context)!.cancel,
    );
  }
}
