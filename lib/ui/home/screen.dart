import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/models/app_model.dart';
import '../app/app_drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return TasksScreen(model: taskModel, type: TasksType.all);
    return new ScopedModelDescendant<AppState>(
        builder: (context, child, app) => Scaffold(
              appBar: AppBar(
                title: Text("Home"),
                actions: <Widget>[],
              ),
              drawer: AppDrawer(),
              body: Container(),
            ));
  }
}
