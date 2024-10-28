part of './../../../core/helpers/export_manager/export_manager.dart';

class BuildTaskStatusIndicator extends StatelessWidget {
  const BuildTaskStatusIndicator({super.key, required this.tasks});
  final TasksModel tasks;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 5.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18).r,
        color: tasks.isDone ? ColorManager.greenColor : ColorManager.blueColor,
      ),
    );
  }
}
