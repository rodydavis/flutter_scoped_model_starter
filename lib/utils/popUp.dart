import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';

void showAlertPopup(BuildContext context, String title, String detail) async {
  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => child,
    );
  }

  return showDemoDialog<Null>(
      context: context,
      child: NativeDialog(
        title: title,
        content: detail,
        actions: <NativeDialogAction>[
          NativeDialogAction(
              text: 'OK',
              isDestructive: false,
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ));
}

void showConfirmationPopup(BuildContext context,
    {String title = "Info", String detail = "", VoidCallback onConfirm}) async {
  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => child,
    );
  }

  return showDemoDialog<Null>(
      context: context,
      child: NativeDialog(
        title: title,
        content: detail,
        actions: <NativeDialogAction>[
          NativeDialogAction(
              text: 'Confirm',
              isDestructive: true,
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              }),
          NativeDialogAction(
              text: 'Cancel',
              isDestructive: false,
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ));
}
