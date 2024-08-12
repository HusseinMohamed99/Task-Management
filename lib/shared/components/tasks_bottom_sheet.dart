import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_management/model/task_model.dart';
import 'package:task_management/shared/adaptive/dialog.dart';
import 'package:task_management/shared/components/date.dart';
import 'package:task_management/shared/components/navigator.dart';
import 'package:task_management/shared/components/size_box.dart';
import 'package:task_management/shared/database/my_database.dart';
import 'package:task_management/shared/providers/settings_provider.dart';
import 'package:task_management/shared/style/theme.dart';

class TasksBottomSheet extends StatefulWidget {
  const TasksBottomSheet({super.key});

  @override
  State<TasksBottomSheet> createState() => _TasksBottomSheetState();
}

class _TasksBottomSheetState extends State<TasksBottomSheet> {
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return Container(
      padding: const EdgeInsets.all(12).r,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.addtask,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color:
                          provider.isDarkMode() ? Colors.white : Colors.black,
                    ),
              ),
            ),
            TextFormField(
              style: TextStyle(
                color: provider.isDarkMode() ? Colors.white : Colors.black,
              ),
              controller: titleController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.title_,
                labelStyle: TextStyle(
                  color: provider.isDarkMode() ? Colors.white : Colors.black,
                ),
                prefixIcon: Icon(
                  size: 24.sp,
                  Icons.edit,
                  color: provider.isDarkMode() ? Colors.white : Colors.black,
                ),
              ),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return AppLocalizations.of(context)!.valid_title;
                }
                if (value.length < 3) {
                  return AppLocalizations.of(context)!.title_length;
                }
                return null;
              },
            ),
            Space(
              width: 0,
              height: 12.h,
            ),
            TextFormField(
              style: TextStyle(
                color: provider.isDarkMode() ? Colors.white : Colors.black,
              ),
              controller: descriptionController,
              maxLines: 6,
              minLines: 1,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.desc,
                labelStyle: TextStyle(
                  color: provider.isDarkMode() ? Colors.white : Colors.black,
                ),
                prefixIcon: Icon(
                  size: 24.sp,
                  Icons.description,
                  color: provider.isDarkMode() ? Colors.white : Colors.black,
                ),
              ),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return AppLocalizations.of(context)!.valid_desc;
                }
                if (value.length < 3) {
                  return AppLocalizations.of(context)!.desc_length;
                }
                return null;
              },
            ),
            Space(width: 0, height: 20.h),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      buildShowDatePicker(context);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.date,
                          style: GoogleFonts.poppins(
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: provider.isDarkMode()
                                      ? Colors.white
                                      : Colors.black,
                                ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 8.0).r,
                          height: 52.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0.w,
                            ),
                            borderRadius: BorderRadius.circular(12).r,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                DateTimeUtils.formatTasksDate(selectedDate),
                                style: GoogleFonts.poppins(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Colors.grey,
                                        fontSize: 20.sp,
                                      ),
                                ),
                              ),
                              Icon(
                                Icons.date_range,
                                color: provider.isDarkMode()
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Space(width: 10.w, height: 0),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      buildShowTimePicker(context);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.time,
                          style: GoogleFonts.poppins(
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: provider.isDarkMode()
                                      ? Colors.white
                                      : Colors.black,
                                ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 8.0).r,
                          height: 52,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey, width: 1.0.w),
                            borderRadius: BorderRadius.circular(12).r,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                selectedTime.format(context),
                                style: GoogleFonts.poppins(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Colors.grey,
                                        fontSize: 20.sp,
                                      ),
                                ),
                              ),
                              Icon(
                                Icons.watch_later_outlined,
                                color: provider.isDarkMode()
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            TextButton(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                onPressed: () {
                  insertTasks();
                  descriptionController.clear();
                  titleController.clear();
                },
                child: Text(
                  AppLocalizations.of(context)!.add,
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.titleLarge,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void insertTasks() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    TasksModel tasks = TasksModel(
      title: titleController.text,
      description: descriptionController.text,
      dateTime: selectedDate,
    );

    MyDialog.showLoadingDialog(context, AppLocalizations.of(context)!.loading);
    try {
      MyDataBase.insertTasks(tasks);
      MyDialog.hideDialog(context);
      MyDialog.showMessage(context, AppLocalizations.of(context)!.task_insert,
          posActionTitle: AppLocalizations.of(context)!.ok, posAction: () {
        pop(context);
      }, isDismissible: false);
    } catch (error) {
      MyDialog.hideDialog(context);
      MyDialog.showMessage(
        context,
        AppLocalizations.of(context)!.task_error,
        posActionTitle: AppLocalizations.of(context)!.try_again,
        posAction: insertTasks,
        isDismissible: false,
      );
    }
  }

  var selectedDate = DateTime.now();
  void buildShowDatePicker(BuildContext context) async {
    var userSelectedDate = await showDatePicker(
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
      context: context,
    );
    if (userSelectedDate == null) {
      return;
    }

    setState(() {
      selectedDate = userSelectedDate;
    });
  }

  var selectedTime = TimeOfDay.now();
  void buildShowTimePicker(BuildContext context) async {
    var userSelectedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: selectedTime,
      context: context,
    );
    if (userSelectedTime == null) {
      return;
    }

    setState(() {
      selectedTime = userSelectedTime;
    });
  }

  Widget getSelectedItem(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: ThemeApp.secondaryColor,
              ),
        ),
        Icon(
          FontAwesomeIcons.circleCheck,
          color: ThemeApp.secondaryColor,
          size: 24.sp,
        )
      ],
    );
  }

  Widget getUnselectedItem(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
