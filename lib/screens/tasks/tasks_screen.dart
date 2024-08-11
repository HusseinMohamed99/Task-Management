import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_management/model/task_model.dart';
import 'package:task_management/screens/tasks/tasks_item.dart';
import 'package:task_management/shared/adaptive/indicator.dart';
import 'package:task_management/shared/components/indicator.dart';
import 'package:task_management/shared/components/size_box.dart';
import 'package:task_management/shared/database/my_database.dart';
import 'package:task_management/shared/providers/settings_provider.dart';
import 'package:task_management/shared/style/theme.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});
  static const String routeName = 'TasksScreen';
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    super.initState();
  }

  var selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Column(
      children: [
        Stack(
          children: [
            Container(
              color: ThemeApp.lightPrimary,
              width: double.infinity,
              height: 85.h,
            ),
            CalendarTimeline(
              initialDate: selectedDate,
              firstDate: DateTime.now().subtract(
                const Duration(days: 365),
              ),
              lastDate: DateTime.now().add(
                const Duration(days: 365),
              ),
              onDateSelected: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
              leftMargin: 14.r,
              monthColor: Colors.black,
              dayColor: Colors.black,
              activeDayColor: Theme.of(context).primaryColor,
              activeBackgroundDayColor: Colors.white,
              dotColor: Theme.of(context).primaryColor,
              selectableDayPredicate: (date) => true,
              locale:
                  settingsProvider.currentLanguage == 'en' ? 'en_ISO' : 'ar',
            ),
          ],
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<TasksModel>>(
            stream: MyDataBase.getTasks(selectedDate),
            builder: (buildContext, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: AdaptiveIndicator(
                    os: getOs(),
                  ),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.error_loading,
                      ),
                      MaterialButton(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        onPressed: () {},
                        child: Text(
                          AppLocalizations.of(context)!.try_again,
                          style: GoogleFonts.poppins(
                            textStyle: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/search.png',
                        color: Colors.grey,
                      ),
                      Space(
                        width: 0,
                        height: 20.h,
                      ),
                      Text(
                        AppLocalizations.of(context)!.no_task,
                        style: GoogleFonts.roboto(
                          fontSize: 20.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }
              var tasks = snapshot.data?.docs
                  .map(
                    (doc) => doc.data(),
                  )
                  .toList();
              return ListView.builder(
                itemBuilder: (_, index) {
                  return TasksItem(tasks![index]);
                },
                itemCount: tasks?.length ?? 0,
              );
            },
          ),
        ),
      ],
    );
  }
}
