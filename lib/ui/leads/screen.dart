import 'package:flutter/material.dart';
import '../app/app_bottom_bar.dart';
import '../app/app_drawer.dart';
import '../app/app_search_bar.dart';

class LeadsScreen extends StatelessWidget {
  void _fabPressed() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leads"),
      ),
      drawer: AppDrawer(),
      body: Container(),
      // bottomNavigationBar: AppBottomBarStateless(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _fabPressed(),
      ),
    );
  }
}
