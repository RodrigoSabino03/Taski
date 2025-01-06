class Task {
  final int id;
  final String name;
  bool isDone;

  Task({
    required this.id,
    required this.name,
    this.isDone = false,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      name: map['name'],
      isDone: map['isDone'] == 1, 
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isDone': isDone ? 1 : 0, 
    };
  }
}
