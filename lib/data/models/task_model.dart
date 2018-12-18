import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../constants.dart';
import '../classes/tasks/task.dart';
import '../classes/tasks/task_module.dart';
import '../repositories/task_repository.dart';
import 'auth_model.dart';

class TaskModel extends Model {
  static TaskModel of(BuildContext context) =>
      ScopedModel.of<TaskModel>(context);

  TaskModule _module = TaskModule(
    tasks: [],
    isLoaded: false,
    lastUpdated: 0,
    date: DateTime.now(),
  );

  List<Task> get tasks => _module?.tasks;
  int get lastUpdated => _module?.lastUpdated;
  DateTime get date => _module?.date ?? DateTime.now();

  set date(DateTime value) {
    _module?.date = value;
    notifyListeners();
  }

  void today() {
    _module?.date = DateTime.now();
    notifyListeners();
  }

  bool get isLoaded {
    if (isStale) return false;
    return _module?.isLoaded;
  }

  bool get isStale {
    // if (!isLoaded) return true;
    if (lastUpdated == 0) return true;
    try {
      return DateTime.now().millisecondsSinceEpoch - lastUpdated >
          kMillisecondsToRefreshData;
    } catch (e) {
      print(e);
      return true;
    }
    // return false;
  }

  Future<bool> loadTasks(BuildContext context) async {
    print("Date: $date");
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    _auth.confirmUserChange();
    // -- Load Items from API or Local --
    var _tasks = await TaskRepository().loadList(_auth, date);

    List<dynamic> _result = _tasks?.result;
    if (_result?.isNotEmpty ?? false) {
      var _results = _result
          ?.map((e) =>
              e == null ? null : Task.fromJson(e as Map<String, dynamic>))
          ?.toList();
      if (_results != null && _results.isNotEmpty) {
        _module?.tasks = _results;
      }
    }
    print("Tasks: ${_result?.length}");

    _module?.lastUpdated = DateTime.now().millisecondsSinceEpoch;
    _module?.isLoaded = true;

    notifyListeners();
    return true;
  }

  Future changeDate(BuildContext context, {DateTime newDate}) async {
    _module?.isLoaded = false;
    notifyListeners();

    _module?.date = newDate;
    await loadTasks(context);
  }
}
