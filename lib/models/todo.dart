import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Todo {
  final String title;
  Todo({
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<Todo> listFromJsonList(List<String> jsonList) {
    return jsonList.map((e) => Todo.fromJson(e)).toList();
  }

  static List<String> listToJsonList(List<Todo> todos) {
    List<String> todoList = todos.map((todo) => todo.toJson()).toList();
    return todoList;
  }
}
