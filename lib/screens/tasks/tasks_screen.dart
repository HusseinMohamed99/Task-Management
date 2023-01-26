import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management/model/task_model.dart';
import 'package:task_management/screens/tasks/tasks_item.dart';
import 'package:task_management/shared/adaptive/indicator.dart';
import 'package:task_management/shared/components/indicator.dart';
import 'package:task_management/shared/components/size_box.dart';
import 'package:task_management/shared/database/my_database.dart';
import 'package:task_management/shared/style/theme.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);
  static const String routeName = 'TasksScreen';

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(color: ThemeApp.lightPrimary,width: double.infinity,height: 85,),
            CalendarTimeline(
              initialDate: selectedDate,
              firstDate: DateTime.now().subtract(const Duration(days: 365)),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              onDateSelected: (date) {
                if (date == null) {
                  return;
                }
                setState(() {
                  selectedDate = date;
                });
              },
              leftMargin: 14,
              monthColor: Colors.black,
              dayColor: Colors.black,
              activeDayColor: Theme.of(context).primaryColor,
              activeBackgroundDayColor: Colors.white,
              dotsColor: Theme.of(context).primaryColor,
              selectableDayPredicate: (date) => true,
              locale: 'en_ISO',

            ),
          ],
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<TasksModel>>(
            stream: MyDataBase.getTasks(selectedDate),
            builder: (buildContext, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: AdaptiveIndicator(os: getOs()));
              }
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Error Loading Tasks,'
                          'Try Again Later'),
                      MaterialButton(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        onPressed: () {},
                        child: Text(
                          'Try Again',
                          style: GoogleFonts.poppins(
                              textStyle: Theme.of(context).textTheme.headline6),
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
                      const Space(width: 0, height: 20),
                      Text(
                        'No Tasks Yet!,',
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }
              var tasks = snapshot.data?.docs.map((doc) => doc.data()).toList();
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

// class TasksProvider extends ChangeNotifier
// {
//   List <TasksModel> tasks ;
//
//   void loadTask()
//   {
//
//   }
//
//   void addTask()
//   {
//     MyDataBase.insertTasks(tasks);
//   }
//
//   void deleteTask()
//   {
//     MyDataBase.deleteTask(tasks);
//   }
// }
