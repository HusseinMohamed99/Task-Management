
class TasksModel
{
   String id;
   String title;
   String description;
   DateTime dateTime;
   bool isDone;

   TasksModel(
   {
    this.id ='',
   required this.title,
   required this.description,
   required this.dateTime,
     this.isDone = false,
});

   TasksModel.fromFireStore(Map<String,dynamic> data) :
       this(
         id: data['id'],
         title: data['title'],
         description: data['description'],
         dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
         isDone: data['isDone'],

       );

  Map<String,dynamic> toFireStore() {
     return
       {
         'id'  : id,
         'title' : title,
         'description': description,
         'isDone' : isDone,
         'dateTime' : dateTime.millisecondsSinceEpoch,
       };
  }
}