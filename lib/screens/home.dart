import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../data/models/auth/model.dart';
import '../ui/app/app_drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: AppDrawer(),
      body: Container(),
    );
  }
}
