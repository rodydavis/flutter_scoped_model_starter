import 'package:flutter/material.dart';

class AppRefreshButton extends StatelessWidget {
  final bool isRefreshing;
  final VoidCallback onRefresh, onCancel;

  AppRefreshButton({
    this.isRefreshing = false,
    this.onRefresh,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    if (isRefreshing) {
      return Container(
        height: 48.0,
        child: InkWell(
          onTap: onCancel,
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5.0),
                child: CircularProgressIndicator(),
              )
            ],
          ),
        ),
      );
    }

    return IconButton(
      tooltip: "Refresh Items",
      icon: Icon(Icons.refresh),
      onPressed: onRefresh,
    );
  }
}
