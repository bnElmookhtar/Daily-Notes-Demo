class ToDoModel{
  String? id,txt;
  bool? isDone;
  ToDoModel({
    required this.id,
    required this.txt,
    this.isDone = false,
  });
  static List<ToDoModel> todoList(){
    return[
      ToDoModel(id: '00', txt: 'اهلا وسهلا',isDone: true),

    ];
  }
}