class TasksModel {
  String id;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;
  String userId; // ✅ جديد: لتحديد صاحب التاسك

  TasksModel({
    this.id = '',
    required this.title,
    required this.description,
    required this.dateTime,
    this.isDone = false,
    this.userId = '', // ✅ تأكد من وجود قيمة افتراضية
  });

  // 🟢 تحويل من Firestore إلى TasksModel
  TasksModel.fromFireStore(Map<String, dynamic> data)
    : this(
        id: data['id'] ?? '',
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
        isDone: data['isDone'] ?? false,
        userId: data['userId'] ?? '', // ✅ قراءة الـ userId
      );

  // 🟢 تحويل من TasksModel إلى Map للتخزين في Firestore
  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'userId': userId, // ✅ إضافة الـ userId في الحفظ
    };
  }
}
