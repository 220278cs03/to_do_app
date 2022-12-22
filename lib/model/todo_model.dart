class TodoModel {
  final String title;
  bool isDone;
  String time;

  TodoModel({required this.title, this.isDone = false, required this.time});

  factory TodoModel.fromJson(Map todo) {
    return TodoModel(title: todo["title"], isDone: todo["is_done"], time: todo["time"]?? "");
  }

  Map toJson() {
    return {"title": title, "is_done": isDone, "time" : time};
  }
}
