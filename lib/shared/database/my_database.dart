part of './../../core/helpers/export_manager/export_manager.dart';

class MyDataBase {
  static CollectionReference<TasksModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection('tasks')
        .withConverter<TasksModel>(
          fromFirestore: (snapshot, _) =>
              TasksModel.fromFireStore(snapshot.data()!),
          toFirestore: (task, _) => task.toFireStore(),
        );
  }

  static Future<void> insertTasks(TasksModel task) async {
    final tasksCollection = getTasksCollection();
    final doc = tasksCollection.doc();
    final userId = await LocalUserHelper.getUserId(); // ✅ Get device/user id

    task
      ..id = doc.id
      ..userId = userId
      ..dateTime = task.dateTime.extractDateOnly();

    await doc.set(task);
  }

  static Stream<QuerySnapshot<TasksModel>> getTasks(DateTime dateTime) async* {
    final userId = await LocalUserHelper.getUserId(); // ✅ Get userId
    final dateMillis = dateTime.extractDateOnly().millisecondsSinceEpoch;

    yield* getTasksCollection()
        .where('dateTime', isEqualTo: dateMillis)
        .where('userId', isEqualTo: userId) // ✅ Filter by device
        .snapshots();
  }

  static Future<void> deleteTask(TasksModel task) async {
    await getTasksCollection().doc(task.id).delete();
  }

  static Future<void> isDone(TasksModel task) async {
    await getTasksCollection().doc(task.id).update({
      'isDone': !task.isDone, // ✅ toggle
    });
  }

  static Future<void> updateTasks(TasksModel task) async {
    await getTasksCollection().doc(task.id).update({
      'title': task.title,
      'description': task.description,
      'dateTime': task.dateTime.millisecondsSinceEpoch,
    });
  }
}
