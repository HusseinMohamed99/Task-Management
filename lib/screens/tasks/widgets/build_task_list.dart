part of './../../../core/helpers/export_manager/export_manager.dart';

class BuildTaskList extends StatelessWidget {
  const BuildTaskList({super.key, required this.selectedDate});
  final DateTime selectedDate;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<TasksModel>>(
      stream: MyDataBase.getTasks(selectedDate),
      builder: (buildContext, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: AdaptiveIndicator());
        }

        if (snapshot.hasError) {
          return const BuildErrorTaskWidget();
        }

        if (snapshot.data?.docs.isEmpty ?? true) {
          return const BuildEmptyTaskWidget();
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
}
