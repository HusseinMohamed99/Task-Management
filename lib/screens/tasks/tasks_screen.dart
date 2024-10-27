part of './../../core/helpers/export_manager/export_manager.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});
  static const String routeName = 'TasksScreen';

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Column(
      children: [
        _buildHeader(settingsProvider),
        Expanded(child: _buildTaskList()),
      ],
    );
  }

  Widget _buildHeader(SettingsProvider settingsProvider) {
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
          onDateSelected: (date) {
            setState(() {
              selectedDate = date;
            });
          },
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

  Widget _buildTaskList() {
    return StreamBuilder<QuerySnapshot<TasksModel>>(
      stream: MyDataBase.getTasks(selectedDate),
      builder: (buildContext, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: AdaptiveIndicator());
        }

        if (snapshot.hasError) {
          return _buildErrorWidget();
        }

        if (snapshot.data?.docs.isEmpty ?? true) {
          return _buildEmptyTaskWidget();
        }

        final tasks =
            snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];

        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (_, index) => TasksItem(tasks[index]),
        );
      },
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.error_loading,
            style: buildTextStyle(
              fontSize: 20,
              context: context,
              settingsProvider: Provider.of<SettingsProvider>(context),
            ),
          ),
          MaterialButton(
            onPressed: () {},
            child: Text(
              AppLocalizations.of(context)!.try_again,
              style: buildTextStyle(
                fontSize: 20,
                context: context,
                settingsProvider: Provider.of<SettingsProvider>(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyTaskWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/search.png',
            color: ColorManager.greyColor,
            width: 80.w,
            height: 80.h,
          ),
          Space(width: 0, height: 20.h),
          Text(
            AppLocalizations.of(context)!.no_task,
            style: buildTextStyle(
              fontSize: 20,
              context: context,
              settingsProvider: Provider.of<SettingsProvider>(context),
            ),
          ),
        ],
      ),
    );
  }
}
