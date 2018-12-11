import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../data/models/task/model.dart';
import '../../../ui/app/app_drawer.dart';
import '../../../ui/general/date_view.dart';

class HomePage extends StatelessWidget {
  final TaskModel model;
  HomePage({this.model});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: AppDrawer(),
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
    model.changeDate(context, newDate: value);
  }

  Widget _buildListView(BuildContext context, {TaskModel model}) {
    if (model.date == null) model.today();

    if (!model.isLoaded || model?.tasks == null) {
      model.loadTasks(context);
      return Center(child: CircularProgressIndicator());
    }

    if (model?.tasks != null && model.tasks.isEmpty) {
      return Text("No Tasks Found");
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: model?.tasks?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        var _item = model?.tasks[index];
        return Text(_item?.leadTaskTitle);
      },
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
          DateViewWidget(
            date: _model?.date,
            dateChanged: (DateTime value) =>
                _onDateChange(context, model: _model, value: value),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildListView(context, model: _model),
            ],
          ),
        ],
      )),
    );
  }
}
