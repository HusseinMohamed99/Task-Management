import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_management/model/task_model.dart';
import 'package:task_management/shared/components/date.dart';
import 'package:task_management/shared/components/navigator.dart';
import 'package:task_management/shared/components/size_box.dart';
import 'package:task_management/shared/database/my_database.dart';
import 'package:task_management/shared/providers/settings_provider.dart';
import 'package:task_management/shared/style/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditTask extends StatefulWidget {
  final TasksModel tasks;

  const EditTask(this.tasks, {super.key});

  static const String routeName = 'EditTask';

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  var formKey = GlobalKey<FormState>();

  var descriptionController = TextEditingController();

  late SettingsProvider provider;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24.sp,
          ),
          onPressed: () {
            pop(context);
          },
        ),
        title: Text(
          AppLocalizations.of(context)!.title,
          style: GoogleFonts.poppins(
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: ThemeApp.lightPrimary,
                  width: double.infinity,
                  height: 85.h,
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20).r,
                    margin: const EdgeInsets.all(20).r,
                    width: 365.w,
                    height: 600.h,
                    decoration: BoxDecoration(
                      color: provider.isDarkMode()
                          ? ThemeApp.darkBottom
                          : Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ).r,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.edit,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: provider.isDarkMode()
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                          ),
                        ),
                        TextFormField(
                          style: TextStyle(
                            color: provider.isDarkMode()
                                ? Colors.white
                                : Colors.black,
                          ),
                          initialValue: widget.tasks.title,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.title_,
                            labelStyle: TextStyle(
                              color: provider.isDarkMode()
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            prefixIcon: Icon(
                              Icons.edit,
                              color: provider.isDarkMode()
                                  ? Colors.white
                                  : Colors.black,
                              size: 24.sp,
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
                          onChanged: (value) {
                            widget.tasks.title = value.trim();
                          },
                        ),
                        Space(width: 0, height: 12.h),
                        TextFormField(
                          style: TextStyle(
                            color: provider.isDarkMode()
                                ? Colors.white
                                : Colors.black,
                          ),
                          initialValue: widget.tasks.description,
                          maxLines: 6,
                          minLines: 1,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: provider.isDarkMode()
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            labelText: AppLocalizations.of(context)!.desc,
                            prefixIcon: Icon(
                              Icons.description,
                              color: provider.isDarkMode()
                                  ? Colors.white
                                  : Colors.black,
                              size: 24.sp,
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
                          onChanged: (value) {
                            widget.tasks.description = value.trim();
                          },
                        ),
                        Space(width: 0, height: 20.h),
                        Column(
                          children: [
                            InkWell(
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
                                          .headline6!
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
                                    padding:
                                        const EdgeInsets.only(left: 14.0).r,
                                    height: 52.h,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0.w,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          DateTimeUtils.formatTasksDate(
                                              widget.tasks.dateTime),
                                          style: GoogleFonts.poppins(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                  color: Colors.grey,
                                                ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.date_range,
                                          color: provider.isDarkMode()
                                              ? Colors.white
                                              : Colors.black,
                                          size: 24.sp,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Space(
                              width: 0,
                              height: 20.h,
                            ),
                            InkWell(
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
                                          .headline6!
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
                                    padding:
                                        const EdgeInsets.only(left: 14.0).r,
                                    height: 52.h,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1.0.w),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          selectedTime.format(context),
                                          style: GoogleFonts.poppins(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                  color: Colors.grey,
                                                ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.watch_later_outlined,
                                          color: provider.isDarkMode()
                                              ? Colors.white
                                              : Colors.black,
                                          size: 24.sp,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.all(30).r,
                          decoration: BoxDecoration(
                            color: ThemeApp.lightPrimary,
                            borderRadius: BorderRadius.circular(20).r,
                          ),
                          child: TextButton(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              onPressed: () {
                                editTask();
                              },
                              child: Text(
                                AppLocalizations.of(context)!.save,
                                style: GoogleFonts.poppins(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void editTask() {
    MyDataBase.updateTasks(widget.tasks).then((value) {
      provider.refreshApp();
      Navigator.pop(context);
    });
  }

  void buildShowDatePicker(BuildContext context) async {
    var userSelectedDate = await showDatePicker(
      initialDate: widget.tasks.dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      context: context,
    );
    if (userSelectedDate == null) {
      return;
    }

    setState(() {
      widget.tasks.dateTime = userSelectedDate;
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
}
