import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_management/model/task_model.dart';
import 'package:task_management/shared/components/date.dart';
import 'package:task_management/shared/components/navigator.dart';
import 'package:task_management/shared/components/size_box.dart';
import 'package:task_management/shared/database/my_database.dart';
import 'package:task_management/shared/providers/settings_provider.dart';
import 'package:task_management/shared/style/theme.dart';

class EditTask extends StatefulWidget {
   TasksModel tasks;
   EditTask(this.tasks, {super.key});
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
   var provider=  Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            pop(context);
          },
        ),
        title: Text(
          'Task Management',
          style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children:
          [
            Stack(
              children: [
                Container(color: ThemeApp.lightPrimary,width: double.infinity,height: 85,),
                Center(child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(20),
                  width: 365,height: 600,decoration:  BoxDecoration(
                    color: provider.isDarkMode() ?  ThemeApp.darkBottom : Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(20),),
                ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Add New Tasks',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            textStyle: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: provider.isDarkMode() ?  Colors.white : Colors.black)),
                      ),
                      TextFormField(
                        style: TextStyle(color: provider.isDarkMode() ?  Colors.white : Colors.black),
                        initialValue: widget.tasks.title,
                        keyboardType: TextInputType.text,
                        decoration:  InputDecoration(
                            labelText: 'Title',
                            labelStyle: TextStyle(color: provider.isDarkMode() ?  Colors.white : Colors.black),
                            prefixIcon: Icon(Icons.edit,color: provider.isDarkMode() ?  Colors.white : Colors.black)),
                        validator: (value) {
                          if (value!.trim().isEmpty || value.trim() == null) {
                            return 'Please Enter a valid Title';
                          }
                          if (value.length < 3) {
                            return 'Title should be at least a 3 characters';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          widget.tasks.title = value.trim();
                        },
                      ),
                      const Space(width: 0, height: 12),
                      TextFormField(
                        style: TextStyle(color: provider.isDarkMode() ?  Colors.white : Colors.black),
                        initialValue: widget.tasks.description,
                        maxLines: 6,
                        minLines: 1,
                        keyboardType: TextInputType.text,
                        decoration:  InputDecoration(
                          labelStyle: TextStyle(color: provider.isDarkMode() ?  Colors.white : Colors.black),
                            labelText: 'Description',
                            prefixIcon: Icon(Icons.description,color: provider.isDarkMode() ?  Colors.white : Colors.black)),
                        validator: (value) {
                          if (value!.trim().isEmpty || value.trim() == null) {
                            return 'Please Enter a valid Description';
                          }
                          if (value.length < 3) {
                            return 'Description should be at least a 3 characters';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          widget.tasks.description = value.trim();
                        },
                      ),
                      const Space(width: 0, height: 20),
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
                                  'Date',
                                  style: GoogleFonts.poppins(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(color: provider.isDarkMode() ?  Colors.white : Colors.black)),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(top: 8.0),
                                  padding: const EdgeInsets.only(left: 14.0),
                                  height: 52,
                                  decoration: BoxDecoration(
                                      border:
                                      Border.all(color: Colors.grey, width: 1.0),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        DateTimeUtils.formatTasksDate(widget.tasks.dateTime),
                                        style: GoogleFonts.poppins(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                       Icon(Icons.date_range,color: provider.isDarkMode() ?  Colors.white : Colors.black),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Space(width: 0, height: 20),
                          InkWell(
                            onTap: () {
                              buildShowTimePicker(context);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Time',
                                  style: GoogleFonts.poppins(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(color: provider.isDarkMode() ?  Colors.white : Colors.black)),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(top: 8.0),
                                  padding: const EdgeInsets.only(left: 14.0),
                                  height: 52,
                                  decoration: BoxDecoration(
                                      border:
                                      Border.all(color: Colors.grey, width: 1.0),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                       Icon(Icons.watch_later_outlined,color: provider.isDarkMode() ?  Colors.white : Colors.black),
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
                        margin: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: ThemeApp.lightPrimary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            onPressed: () {
                              editTask();

                            },
                            child: Text(
                              'Save Changes',
                              style: GoogleFonts.poppins(
                                  textStyle: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white)),
                            )),
                      ),
                    ],
                  ),

                ),),
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
       initialTime:  selectedTime,
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
