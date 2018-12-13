import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../constants.dart';
import '../../classes/tasks/task.dart';
import '../../repositories/task_repository.dart';
import '../auth/model.dart';

class TaskModel extends Model {
  List<Task> _tasks = [];
  DateTime _date;
  bool _loaded = false;
  int _lastUpdated = 0;

  List<Task> get tasks => _tasks;

  int get lastUpdated => _lastUpdated;

  DateTime get date => _date;
  set date(DateTime value) {
    _date = value;
    notifyListeners();
  }

  void today() {
    _date = DateTime.now();
    notifyListeners();
  }

  bool get isLoaded {
    if (isStale) return false;
    return _loaded;
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
    var _result = await TaskRepository().loadList(_auth, _date);
    _tasks = _result?.result;
    _lastUpdated = DateTime.now().millisecondsSinceEpoch;
    _loaded = true;
    print("Tasks: ${_tasks?.length}");
    notifyListeners();
    return true;
  }

  Future changeDate(BuildContext context, {DateTime newDate}) async {
    _loaded = false;
    notifyListeners();

    _date = newDate;
    await loadTasks(context);
  }
}
