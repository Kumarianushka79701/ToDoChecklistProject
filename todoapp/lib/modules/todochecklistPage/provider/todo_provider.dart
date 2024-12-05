import 'package:flutter/material.dart';

class TodoProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _tasks = [];

  List<Map<String, dynamic>> get tasks => List.unmodifiable(_tasks);

  void addTask(String title) {
    if (title.isNotEmpty) {
      _tasks.add({'title': title, 'isComplete': false});
      notifyListeners();
    }
  }

  void toggleTaskCompletion(int index) {
    _tasks[index]['isComplete'] = !_tasks[index]['isComplete'];
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }
}
