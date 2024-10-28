part of './../../core/helpers/export_manager/export_manager.dart';

class EditTask extends StatefulWidget {
  final TasksModel tasks;

  const EditTask(this.tasks, {super.key});

  static const String routeName = 'EditTask';

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final selectedTime = ValueNotifier<TimeOfDay>(TimeOfDay.now());

  late SettingsProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<SettingsProvider>(context);
    double responsiveHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.title,
          style: buildTextStyle(
            fontSize: 14,
            context: context,
            settingsProvider: provider,
          ),
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          Container(
            color: ThemeApp.lightPrimary,
            width: double.infinity,
            height: 85.h,
          ),
          SingleChildScrollView(
            child: Center(
              child: _buildFormContainer(responsiveHeight),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormContainer(double responsiveHeight) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: provider.isDarkMode()
            ? ThemeApp.darkBottom
            : ColorManager.whiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)).r,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTitle(AppLocalizations.of(context)!.edit),
          CustomTitleFormField(provider: provider, task: widget.tasks),
          _buildSpacing(responsiveHeight),
          CustomDescriptionFormField(provider: provider, task: widget.tasks),
          _buildSpacing(responsiveHeight),
          _buildDateAndTimePicker(responsiveHeight),
          _buildSpacing(responsiveHeight),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: buildTextStyle(
        fontSize: 20,
        context: context,
        settingsProvider: provider,
      ),
    );
  }

  Widget _buildDateAndTimePicker(double responsiveHeight) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _selectDate(context),
          child: _buildPickerField(
            AppLocalizations.of(context)!.date,
            DateTimeUtils.formatTasksDate(widget.tasks.dateTime),
            Icons.date_range,
          ),
        ),
        _buildSpacing(responsiveHeight),
        InkWell(
          onTap: () => _selectTime(context),
          child: ValueListenableBuilder<TimeOfDay>(
            valueListenable: selectedTime,
            builder: (context, time, child) {
              return _buildPickerField(
                AppLocalizations.of(context)!.time,
                time.format(context),
                Icons.watch_later_outlined,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPickerField(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: provider.isDarkMode()
                      ? ColorManager.whiteColor
                      : ColorManager.blackColor,
                ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 8.0).r,
          padding: const EdgeInsets.only(left: 14.0).r,
          height: 52.h,
          decoration: BoxDecoration(
            border: Border.all(color: ColorManager.greyColor, width: 1.0.w),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                value,
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: ColorManager.greyColor,
                      ),
                ),
              ),
              Icon(
                icon,
                color: provider.isDarkMode()
                    ? ColorManager.whiteColor
                    : ColorManager.blackColor,
                size: 24.sp,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSpacing(double height) =>
      Space(width: 0, height: height * .012.h);

  Widget _buildSaveButton() {
    return Container(
      decoration: BoxDecoration(
        color: ThemeApp.lightPrimary,
        borderRadius: BorderRadius.circular(12).r,
      ),
      child: TextButton(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        onPressed: () {
          editTask();
          if (mounted) Navigator.pop(context);
        },
        child: Text(
          AppLocalizations.of(context)!.save,
          style: GoogleFonts.poppins(
            textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: ColorManager.whiteColor,
                ),
          ),
        ),
      ),
    );
  }

  void editTask() {
    MyDataBase.updateTasks(widget.tasks).then((_) {
      provider.refreshApp();
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    var selectedDate = await showDatePicker(
      initialDate: widget.tasks.dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      context: context,
    );
    if (selectedDate != null) {
      setState(() => widget.tasks.dateTime = selectedDate);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    var time = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: selectedTime.value,
      context: context,
    );
    if (time != null) {
      selectedTime.value = time;
    }
  }
}

class CustomDescriptionFormField extends StatelessWidget {
  final SettingsProvider provider;
  final TasksModel task;

  const CustomDescriptionFormField({
    super.key,
    required this.provider,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: provider.isDarkMode()
            ? ColorManager.whiteColor
            : ColorManager.blackColor,
      ),
      initialValue: task.description,
      maxLines: 5,
      minLines: 1,
      keyboardType: TextInputType.text,
      decoration: _buildInputDecoration(
        labelText: AppLocalizations.of(context)!.desc,
        icon: Icons.description,
        provider: provider,
      ),
      validator: (value) => _validateDescription(value, context: context),
      onChanged: (value) => task.description = value.trim(),
    );
  }

  String? _validateDescription(String? value, {required BuildContext context}) {
    if (value!.trim().isEmpty) return AppLocalizations.of(context)!.valid_desc;
    if (value.length < 3) return AppLocalizations.of(context)!.desc_length;
    return null;
  }
}

class CustomTitleFormField extends StatelessWidget {
  final SettingsProvider provider;
  final TasksModel task;

  const CustomTitleFormField({
    super.key,
    required this.provider,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 3,
      minLines: 1,
      style: TextStyle(
        color: provider.isDarkMode()
            ? ColorManager.whiteColor
            : ColorManager.blackColor,
      ),
      initialValue: task.title,
      keyboardType: TextInputType.text,
      decoration: _buildInputDecoration(
        labelText: AppLocalizations.of(context)!.title_,
        icon: Icons.title,
        provider: provider,
      ),
      validator: (value) => _validateTitle(value, context),
      onChanged: (value) => task.title = value.trim(),
    );
  }

  String? _validateTitle(String? value, BuildContext context) {
    if (value!.trim().isEmpty) return AppLocalizations.of(context)!.valid_title;
    if (value.length < 3) return AppLocalizations.of(context)!.title_length;
    return null;
  }
}

InputDecoration _buildInputDecoration({
  required String labelText,
  required IconData icon,
  required SettingsProvider provider,
}) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: TextStyle(
      color: provider.isDarkMode()
          ? ColorManager.whiteColor
          : ColorManager.blackColor,
    ),
    prefixIcon: Icon(
      icon,
      color: provider.isDarkMode()
          ? ColorManager.whiteColor
          : ColorManager.blackColor,
      size: 24.sp,
    ),
  );
}
