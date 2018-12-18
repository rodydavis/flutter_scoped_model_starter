import 'package:flutter/material.dart';
import '../app/app_bottom_bar.dart';
import '../app/app_drawer.dart';
import '../general/simple_fab.dart';
import '../app/app_search_bar.dart';

class LeadsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AppSearchBar(),
          actions: <Widget>[
            AppSearchButton(),
          ],
        ),
        drawer: AppDrawer(),
        body: Container(),
        bottomNavigationBar: AppBottomBarStateless(
          buttons: [
            IconButton(
              icon: Icon(Icons.sort_by_alpha),
              onPressed: () => _sortPressed(),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: SimpleFAB(
          child: Icon(Icons.add),
          onPressed: () => _fabPressed(),
        ));
  }

  void _fabPressed() {}

  void _sortPressed() {}
}
