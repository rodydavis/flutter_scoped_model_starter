import 'package:flutter/material.dart';
import '../../../utils/popUp.dart';

class AppDeleteButton extends StatelessWidget {
  final bool isDeleting;
  final VoidCallback onDelete;

  AppDeleteButton({this.isDeleting = false, this.onDelete});

  @override
  Widget build(BuildContext context) {
    if (isDeleting) {
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
      tooltip: "Delete Item",
      icon: Icon(Icons.delete),
      onPressed: () => showConfirmationPopup(context,
          detail: "Are you sure you want to delete?", onConfirm: onDelete),
    );
  }
}
