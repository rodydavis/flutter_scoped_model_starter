import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/models/task_model.dart';
import '../../ui/app/app_drawer.dart';
import '../../ui/general/date_view.dart';

class TasksScreen extends StatelessWidget {
  final TaskModel model;
  final TasksType type;
  TasksScreen({this.model, this.type = TasksType.all});
  @override
  Widget build(BuildContext context) {
    String _title = "Home";
    if (type == TasksType.contact) _title = "Contact Tasks";
    if (type == TasksType.core_lead) _title = "Core Leads Tasks";
    if (type == TasksType.lead) _title = "Lead Tasks";
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      drawer: type == TasksType.all ? AppDrawer() : null,
      body: ScopedModel<TaskModel>(
        model: model,
        child: _DateView(),
      ),
    );
  }
}

class _DateView extends StatefulWidget {
  @override
  __DateViewState createState() => __DateViewState();
}

class __DateViewState extends State<_DateView> {
  void _onDateChange(BuildContext context, {TaskModel model, DateTime value}) {
    model.changeDate(value);
  }

  Widget _buildListView(BuildContext context, {TaskModel model}) {
    if (model.date == null) model.today();

    if (!model.isLoaded || model?.tasks == null) {
      model.loadTasks();
      return Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final _items = model?.tasks;

    if (_items != null && _items.isEmpty) {
      return Center(
        child: Text("No Tasks Found"),
      );
    }

    return Container(
      // height: 400.0,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _items.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          var _item = _items[index];
          return ListTile(
            leading: Icon(Icons.info),
            title: Text(_item?.leadTaskTitle),
            subtitle: Text(_item?.leadTaskDescription),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _model = ScopedModel.of<TaskModel>(context, rebuildOnChange: true);
    return SingleChildScrollView(
      child: Container(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            child: DateViewWidget(
              date: _model?.date,
              dateChanged: _model.changeDate,
            ),
          ),
          _buildListView(context, model: _model),
        ],
      )),
    );
  }
}
