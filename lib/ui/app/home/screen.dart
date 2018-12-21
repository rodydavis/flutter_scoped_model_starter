import 'package:flutter/material.dart';

import '../../tasks/screen.dart';
import '../../../data/models/task_model.dart';

class HomePage extends StatelessWidget {
  final TaskModel taskModel;

  HomePage({this.taskModel});

  @override
  Widget build(BuildContext context) {
    return TasksScreen(model: taskModel, type: TasksType.all);
  }
}
