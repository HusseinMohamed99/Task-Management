import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management/shared/components/size_box.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);
  static const String routeName = 'TasksScreen';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateSelected: (date) => print(date),
          leftMargin: 20,
          monthColor: Colors.black,
          dayColor: Colors.grey,
          activeDayColor: Theme.of(context).primaryColor,
          activeBackgroundDayColor: Colors.white,
          dotsColor: Theme.of(context).primaryColor,
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (_, index) {
              return const TasksItem();
            },
            itemCount: 10,
          ),
        )
      ],
    );
  }
}

class TasksItem extends StatelessWidget {
  const TasksItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(18),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Slidable(

        startActionPane: ActionPane(
          dismissible:  DismissiblePane(onDismissed: () {},),
          extentRatio: 0.2,
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext buildContext) {},
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete_forever,
              label: 'Delete',
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
              ),
            ),
          ],
        ),

        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const Space(width: 25, height: 0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Play basket ball',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          textStyle: Theme.of(context).textTheme.headline6),
                    ),
                    const Space(width: 0, height: 10),
                    Text(
                      'This Description',
                      style: GoogleFonts.roboto(
                          textStyle: Theme.of(context).textTheme.subtitle2),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
