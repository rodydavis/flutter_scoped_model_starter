import 'package:flutter/material.dart';

class AppRefreshButton extends StatelessWidget {
  final bool isRefreshing;
  final VoidCallback onRefresh;

  AppRefreshButton({this.isRefreshing = false, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    if (isRefreshing) {
      return Container(
        height: 48.0,
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5.0),
              child: CircularProgressIndicator(),
            )
          ],
        ),
      );
    }

    return IconButton(
      icon: Icon(Icons.refresh),
      onPressed: onRefresh,
    );
  }
}
