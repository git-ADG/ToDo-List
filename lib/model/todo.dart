import 'dart:convert';

class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  @override
  String toString() {
    return json.encode({
      "id": id,
      "todoText": todoText,
      'isDone': isDone,
    });
  }

  static ToDo fromString(String dataString) {
    dynamic data = json.decode(dataString);
    return ToDo(
      id: data['id'],
      todoText: data['todoText'],
      isDone: data['isDone'],
    );
  }

  static List<ToDo> todoList() {
    return [
      ToDo(
        id: '01',
        todoText: 'Write Practicals',
      ),
      ToDo(
        id: '02',
        todoText: 'Buy Supplies',
      ),
      ToDo(
        id: '03',
        todoText: 'Check Emails',
      ),
      ToDo(
        id: '04',
        todoText: 'Finish Assignment',
      ),
      ToDo(
        id: '05',
        todoText: 'Work on mobile apps for 2 hour',
      ),
    ];
  }
}
