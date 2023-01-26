import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management/model/task_model.dart';
import 'package:task_management/shared/components/date.dart';

class MyDataBase {
  static CollectionReference<TasksModel> getTasksCollection() {
    var tasksCollection = FirebaseFirestore.instance
        .collection('tasks')
        .withConverter<TasksModel>(
          fromFirestore: (snapshot, options) =>
              TasksModel.fromFireStore(snapshot.data()!),
          toFirestore: (tasks, options) => tasks.toFireStore(),
        );
    return tasksCollection;
  }

  static Future<void> insertTasks(TasksModel tasks) {
    var tasksCollection = getTasksCollection();

    var doc = tasksCollection.doc();
    tasks.id = doc.id;
    tasks.dateTime = tasks.dateTime.extractDateOnly();
    return doc.set(tasks);
  }

  static Stream<QuerySnapshot<TasksModel>> getTasks(DateTime dateTime) {
    return getTasksCollection()
        .where('dateTime',
            isEqualTo: dateTime.extractDateOnly().millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(TasksModel tasks) {
    var taskDoc = getTasksCollection().doc(tasks.id);
    return taskDoc.delete();
  }

  static isDone(TasksModel tasks) {
    getTasksCollection().doc(tasks.id).update({
      'isDone': tasks.isDone ? false : true,
    });
  }

  static Future<void> updateTasks(TasksModel tasks) {

    CollectionReference todoRef = getTasksCollection();
    return todoRef.doc(tasks.id).update({
      'title': tasks.title,
      'description': tasks.description,
      'dateTime': tasks.dateTime.millisecondsSinceEpoch,
    });

  }
}
