import 'package:flutter/material.dart';

class AppInputField extends StatelessWidget {
  final Widget leading, trailing, subtitle;
  final TextEditingController controller;
  final String name, onError;
  final bool autoFocus, required, multiLine, numeric;
  final ValueChanged<String> onChanged;

  AppInputField({
    this.controller,
    this.name = "Item",
    this.autoFocus = false,
    this.required,
    this.leading,
    this.subtitle,
    this.trailing,
    this.multiLine = false,
    this.numeric = false,
    this.onError,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: TextFormField(
        autofocus: autoFocus,
        controller: controller,
        decoration: InputDecoration(labelText: name),
        keyboardType: multiLine
            ? TextInputType.multiline
            : getKeyboard(name, numeric: numeric),
        validator: (val) => validator(val,
            type: name, required: required, onError: onError, numeric: numeric),
        onFieldSubmitted: onChanged,
        onSaved: onChanged,
        maxLines: multiLine ? null : 1,
      ),
      subtitle: subtitle,
      trailing: trailing,
    );
  }
}

String validator(String value,
    {String type,
    bool required = false,
    String onError,
    bool numeric = false}) {
  if (numeric) {
    if (value.isEmpty && required) return onError ?? 'Number is required.';
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (nameExp.hasMatch(value))
      return 'Please enter only numerial characters.';
    num _number = num.tryParse(value);
    if (_number == null) return 'Please enter a valid number';
  }
  if (required ?? false) {
    if (value != null && value.isEmpty) return onError ?? '$type Required';
  }

  return null;
}

TextInputType getKeyboard(String type, {bool numeric = false}) {
  if (numeric) return TextInputType.number;
  if (type.contains("Email")) return TextInputType.emailAddress;
  return TextInputType.text;
}

//class AppInlineEditingField extends StatefulWidget {
//  @override
//  _InlineEditingState createState() {
//    return new _InlineEditingState();
//  }
//}
//
//class _InlineEditingState extends State<AppInlineEditingField> {
//  bool _editing = false;
//  @override
//  Widget build(BuildContext context) {
//    if (_editing) {
//      return ListTile(
//        title: TextField(),
//        trailing: IconButton(
//            icon: Icon(Icons.close),
//            onPressed: () {
//              setState(() {
//                _editing = false;
//              });
//            }),
//      );
//    }
//    return ListTile(
//      title: Text("Text"),
//      trailing: IconButton(
//          icon: Icon(Icons.edit),
//          onPressed: () {
//            setState(() {
//              _editing = true;
//            });
//          }),
//    );
//  }
//}
