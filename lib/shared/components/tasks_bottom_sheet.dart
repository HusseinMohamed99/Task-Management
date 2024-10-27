part of './../../core/helpers/export_manager/export_manager.dart';

class TasksBottomSheet extends StatefulWidget {
  const TasksBottomSheet({super.key});

  @override
  State<TasksBottomSheet> createState() => _TasksBottomSheetState();
}

class _TasksBottomSheetState extends State<TasksBottomSheet> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);
    final isDarkMode = provider.isDarkMode();

    return Container(
      padding: const EdgeInsets.all(12).r,
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTitle(context, isDarkMode),
              _buildTextField(
                context,
                titleController,
                AppLocalizations.of(context)!.title_,
                Icons.edit,
                (value) => _validateField(
                    value,
                    AppLocalizations.of(context)!.valid_title,
                    AppLocalizations.of(context)!.title_length),
                isDarkMode,
              ),
              Space(
                height: MediaQuery.sizeOf(context).height * .009.h,
                width: 0,
              ),
              _buildTextField(
                context,
                descriptionController,
                AppLocalizations.of(context)!.desc,
                Icons.description,
                (value) => _validateField(
                    value,
                    AppLocalizations.of(context)!.valid_desc,
                    AppLocalizations.of(context)!.desc_length),
                isDarkMode,
                maxLines: 6,
              ),
              Space(
                height: MediaQuery.sizeOf(context).height * .01.h,
                width: 0,
              ),
              _buildDateAndTimePickers(context, isDarkMode),
              Space(
                height: MediaQuery.sizeOf(context).height * .01.h,
                width: 0,
              ),
              _buildAddButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, bool isDarkMode) {
    return Text(
      AppLocalizations.of(context)!.addtask,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        textStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
      ),
    );
  }

  Widget _buildTextField(
      BuildContext context,
      TextEditingController controller,
      String label,
      IconData prefixIcon,
      String? Function(String?) validator,
      bool isDarkMode,
      {int maxLines = 3}) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
      keyboardType: TextInputType.text,
      maxLines: maxLines,
      minLines: 1,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        prefixIcon: Icon(
            size: 24.sp,
            prefixIcon,
            color: isDarkMode ? Colors.white : Colors.black),
      ),
      validator: validator,
    );
  }

  String? _validateField(String? value, String emptyError, String lengthError) {
    if (value!.trim().isEmpty) {
      return emptyError;
    }
    if (value.length < 3) {
      return lengthError;
    }
    return null;
  }

  Widget _buildDateAndTimePickers(BuildContext context, bool isDarkMode) {
    return Row(
      children: [
        _buildDatePicker(context, isDarkMode),
        Space(width: 10.w, height: 0),
        _buildTimePicker(context, isDarkMode),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context, bool isDarkMode) {
    return Expanded(
      child: InkWell(
        onTap: () => _showDatePicker(context),
        child: _buildPickerContainer(
          context,
          AppLocalizations.of(context)!.date,
          DateTimeUtils.formatTasksDate(selectedDate),
          Icons.date_range,
          isDarkMode,
        ),
      ),
    );
  }

  Widget _buildTimePicker(BuildContext context, bool isDarkMode) {
    return Expanded(
      child: InkWell(
        onTap: () => _showTimePicker(context),
        child: _buildPickerContainer(
          context,
          AppLocalizations.of(context)!.time,
          selectedTime.format(context),
          Icons.watch_later_outlined,
          isDarkMode,
        ),
      ),
    );
  }

  Widget _buildPickerContainer(BuildContext context, String label, String value,
      IconData icon, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 8.0).r,
          height: 52.h,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1.0.w),
            borderRadius: BorderRadius.circular(12).r,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                value,
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.grey,
                        fontSize: 20.sp,
                      ),
                ),
              ),
              Icon(icon, color: isDarkMode ? Colors.white : Colors.black),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return TextButton(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      onPressed: () {
        _insertTasks();
        descriptionController.clear();
        titleController.clear();
      },
      child: Text(
        AppLocalizations.of(context)!.add,
        style: GoogleFonts.poppins(
            textStyle: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }

  void _insertTasks() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    final tasks = TasksModel(
      title: titleController.text,
      description: descriptionController.text,
      dateTime: selectedDate,
    );

    MyDialog.showLoadingDialog(context, AppLocalizations.of(context)!.loading);
    try {
      MyDataBase.insertTasks(tasks);
      MyDialog.hideDialog(context);
      MyDialog.showMessage(
        context,
        AppLocalizations.of(context)!.task_insert,
        posActionTitle: AppLocalizations.of(context)!.ok,
        posAction: () => pop(context),
        isDismissible: false,
      );
    } catch (error) {
      MyDialog.hideDialog(context);
      MyDialog.showMessage(
        context,
        AppLocalizations.of(context)!.task_error,
        posActionTitle: AppLocalizations.of(context)!.try_again,
        posAction: _insertTasks,
        isDismissible: false,
      );
    }
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final userSelectedDate = await showDatePicker(
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      context: context,
    );
    if (userSelectedDate != null) {
      setState(() {
        selectedDate = userSelectedDate;
      });
    }
  }

  Future<void> _showTimePicker(BuildContext context) async {
    final userSelectedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: selectedTime,
      context: context,
    );
    if (userSelectedTime != null) {
      setState(() {
        selectedTime = userSelectedTime;
      });
    }
  }

  Widget getSelectedItem(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: ThemeApp.secondaryColor),
        ),
        Icon(FontAwesomeIcons.circleCheck,
            color: ThemeApp.secondaryColor, size: 24.sp),
      ],
    );
  }

  Widget getUnselectedItem(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
