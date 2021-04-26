class Todo {
  String id;
  String title;
  String description;
  DateTime createdTime;
  DateTime updatedTime;
  DateTime doDate;
  bool isDone;

  Todo(
      {this.id,
      this.title,
      this.description,
      this.createdTime,
      this.updatedTime,
      this.doDate,
      this.isDone = false});
}

class RoutineTodo extends Todo {
  int numDo; //한 횟수
  int numDone; //해야하는 횟수(일자)

  RoutineTodo(
      {id,
      title,
      createdTime,
      updatedTime,
      doDate,
      isDone,
      this.numDo,
      this.numDone})
      : super(
            id: id,
            title: title,
            createdTime: createdTime,
            updatedTime: updatedTime,
            doDate: doDate,
            isDone: isDone);
}

class MultiTodo extends Todo {
  String friendID;

  MultiTodo(
      {id, title, createdTime, updatedTime, doDate, isDone, this.friendID})
      : super(
            id: id,
            title: title,
            createdTime: createdTime,
            updatedTime: updatedTime,
            doDate: doDate,
            isDone: isDone);
}
