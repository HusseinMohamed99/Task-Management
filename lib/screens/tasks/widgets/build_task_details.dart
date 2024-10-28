part of './../../../core/helpers/export_manager/export_manager.dart';

class BuildTaskDetails extends StatelessWidget {
  const BuildTaskDetails({super.key, required this.tasks});
  final TasksModel tasks;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            tasks.title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: tasks.isDone
                  ? ColorManager.greenColor
                  : ColorManager.blueColor,
              textStyle: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Space(height: 6.h, width: 0),
          Text(
            tasks.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: buildTextStyle(
              fontSize: 12,
              context: context,
              settingsProvider: Provider.of<SettingsProvider>(context),
            ),
          ),
        ],
      ),
    );
  }
}
