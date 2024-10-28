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
        CalendarTimeline(
          initialDate: selectedDate,
          fontSize: getResponsiveFontSize(context, fontSize: 20),
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateSelected: onDateSelected,
          leftMargin: 14.r,
          monthColor: ColorManager.blackColor,
          dayColor: ColorManager.blackColor,
          activeDayColor: Theme.of(context).primaryColor,
          activeBackgroundDayColor: ColorManager.whiteColor,
          dotColor: Theme.of(context).primaryColor,
          selectableDayPredicate: (date) => true,
          locale: settingsProvider.currentLanguage == 'en' ? 'en_ISO' : 'ar',
        ),
      ],
    );
  }
}
