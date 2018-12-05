import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../data/models/counter.dart';
import '../widgets/containers/counter/add.dart';
import '../widgets/containers/counter/subtract.dart';
import '../data/models/theme.dart';

class HomePage extends StatefulWidget {
  final ThemeModel model;
  HomePage({this.model});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    widget.model.loadSavedTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new ScopedModel<CounterModel>(
      model: CounterModel(),
      child: CounterPage(),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = ScopedModel.of<CounterModel>(context, rebuildOnChange: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter Example"),
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () => Navigator.pushNamed(context, "/settings"),
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: new Text("Increment or Decrement"),
            leading: new Text(
              '${model.counter}',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ],
      ),
      floatingActionButton: ButtonBar(
        children: <Widget>[
          CounterSubtractButton(),
          CounterAddButton(),
        ],
      ),
    );
  }
}
