import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management/shared/components/size_box.dart';

class TasksBottomSheet extends StatefulWidget {
  const TasksBottomSheet({super.key});

  @override
  State<TasksBottomSheet> createState() => _TasksBottomSheetState();
}

class _TasksBottomSheetState extends State<TasksBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
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
                    .copyWith(color: Colors.black)),
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(labelText: 'Enter your task'),
          ),
          const Space(width: 0, height: 12),
          TextFormField(
            maxLines: 6,
            minLines: 1,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          Text(
            'Select Date',
            style: GoogleFonts.poppins(
                textStyle: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.black)),
          ),
          InkWell(
            onTap: () {
              buildShowDatePicker(context);
            },
            child: Text(
              '${DateTime.now().year} - ${DateTime.now().month} - ${DateTime.now().day}',
              style: GoogleFonts.poppins(
                  textStyle: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Theme.of(context).primaryColor)),
            ),
          ),
          const Spacer(),
          TextButton(
            clipBehavior: Clip.antiAliasWithSaveLayer,
              onPressed: (){}, child: Text('Submit',style: GoogleFonts.poppins(
              textStyle: Theme.of(context)
                  .textTheme
                  .headline6),))
        ],
      ),
    );
  }

 void buildShowDatePicker(BuildContext context) {
     showDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              context: context,

            );
  }

  Widget getSelectedItem(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.copyWith(color: Theme.of(context).accentColor),
        ),
        Icon(
          FontAwesomeIcons.circleCheck,
          color: Theme.of(context).accentColor,
        )
      ],
    );
  }

  Widget getUnselectedItem(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
