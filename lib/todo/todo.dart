import 'dart:convert';

class Todo {
  int id;
  String desc;
  bool done;

  Todo(this.id, this.desc, this.done);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'desc': desc,
      'done': done,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      map['id']?.toInt() ?? 0,
      map['desc'] ?? '',
      map['done'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));
}
