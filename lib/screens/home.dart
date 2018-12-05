import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../data/models/counter.dart';
import '../data/models/theme.dart';
import '../screens/counter_page.dart';

class HomePage extends StatefulWidget {
  final ThemeModel themeModel;
  HomePage({this.themeModel});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CounterModel _counterModel = CounterModel();
  @override
  void initState() {
    widget.themeModel.loadSavedTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new ScopedModel<CounterModel>(
      model: _counterModel,
      child: CounterPage(),
    );
  }
}
