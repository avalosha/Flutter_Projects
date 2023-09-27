import 'package:flutter/foundation.dart';
import 'task.dart';
import 'dart:collection';

class TaskData with ChangeNotifier {
  final List<Task> _tasks = [];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView((_tasks));
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(String name) {
    _tasks.add(Task(name: name));
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toogleDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    //final index = _tasks.indexWhere((element) => element.name == name);
    _tasks.remove(task);
    notifyListeners();
  }
}
