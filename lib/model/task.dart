class Task {
  int? id;
  String? task;
  DateTime? date;
  String? description;

  taskMap() {
    var mapping = <String, dynamic>{};
    mapping['id'] = id;
    mapping['task'] = task;
    mapping['date'] = date.toString();
    mapping['description'] = description;
    return mapping;
  }
}
