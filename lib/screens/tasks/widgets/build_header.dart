part of './../../../core/helpers/export_manager/export_manager.dart';

class BuildHeader extends StatelessWidget {
  const BuildHeader(
      {super.key,
      required this.settingsProvider,
      required this.selectedDate,
      required this.onDateSelected});
  final SettingsProvider settingsProvider;
  final DateTime selectedDate;
  final void Function(DateTime) onDateSelected;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: ThemeApp.lightPrimary,
          width: double.infinity,
          height: 70.h,
        ),
       TableCalendar(
          firstDay: DateTime.now().subtract(const Duration(days: 365)),
          lastDay: DateTime.now().add(const Duration(days: 365)),
          focusedDay: selectedDate,
          startingDayOfWeek: StartingDayOfWeek.saturday,
          calendarFormat: CalendarFormat.week, // ✅ تقويم أفقي (أسبوعي)
          selectedDayPredicate: (day) => isSameDay(selectedDate, day),
          onDaySelected: (selected, focused) {
            onDateSelected(selected);
          },

          // ✅ التنسيق والستايلات
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            selectedTextStyle: TextStyle(color: ColorManager.whiteColor),
            defaultTextStyle: TextStyle(
              color: ColorManager.blackColor,
              fontSize: getResponsiveFontSize(context, fontSize: 20),
            ),
            weekendTextStyle: TextStyle(color: ColorManager.blackColor),
          ),

          daysOfWeekStyle: DaysOfWeekStyle(
            weekendStyle: TextStyle(color: ColorManager.blackColor),
            weekdayStyle: TextStyle(color: ColorManager.blackColor),
          ),

          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleTextFormatter: (date, locale) =>
                intl.DateFormat.MMMM(locale).format(date),
            titleCentered: true,
            titleTextStyle: TextStyle(
              color: ColorManager.blackColor,
              fontSize: getResponsiveFontSize(context, fontSize: 18),
            ),
            leftChevronIcon: Icon(
              Icons.chevron_left,
              color: ColorManager.blackColor,
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              color: ColorManager.blackColor,
            ),
          ),

          locale: settingsProvider.currentLanguage == 'en' ? 'en' : 'ar',
        )

      ],
    );
  }
}
