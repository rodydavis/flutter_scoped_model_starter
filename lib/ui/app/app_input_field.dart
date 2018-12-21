import 'package:flutter/material.dart';

class AppInputField extends StatelessWidget {
  final Widget leading, trailing, subtitle;
  final TextEditingController controller;
  final String name;
  final bool autoFocus, required, multiLine;

  AppInputField({
    this.controller,
    this.name = "Item",
    this.autoFocus = false,
    this.required,
    this.leading,
    this.subtitle,
    this.trailing,
    this.multiLine = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: TextFormField(
        autofocus: autoFocus,
        controller: controller,
        decoration: InputDecoration(labelText: name),
        keyboardType: multiLine ? TextInputType.multiline : getKeyboard(name),
        validator: (val) => validator(val, type: name, required: required),
        maxLines: multiLine ? null : 1,
      ),
      subtitle: subtitle,
      trailing: trailing,
    );
  }
}

String validator(String value, {String type, bool required = false}) {
  if (value.isEmpty && required) return 'Please enter a $type';
  return null;
}

TextInputType getKeyboard(String type) {
  if (type.contains("Email")) return TextInputType.emailAddress;
  return TextInputType.text;
}
