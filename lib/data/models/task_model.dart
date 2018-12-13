import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../constants.dart';
import '../classes/tasks/task.dart';
import '../repositories/task_repository.dart';
import 'auth_model.dart';
import '../classes/tasks/task_module.dart';

class TaskModel extends Model {
  TaskModule _module;

  List<Task> get tasks => _module?.tasks;

  int get lastUpdated => _module.lastUpdated;

  DateTime get date => _module?.date;
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
    return _module.isLoaded;
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
    var _result = await TaskRepository().loadList(_auth, _module?.date);
    _module?.tasks = _result?.result;
    _module.lastUpdated = DateTime.now().millisecondsSinceEpoch;
    _module.isLoaded = true;
    print("Tasks: ${_module?.tasks?.length}");
    notifyListeners();
    return true;
  }

  Future changeDate(BuildContext context, {DateTime newDate}) async {
    _module.isLoaded = false;
    notifyListeners();

    _module?.date = newDate;
    await loadTasks(context);
  }
}
