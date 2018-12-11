import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/contact/fields.dart';
import '../../data/models/contact/list.dart';

class ContactItemEdit extends StatefulWidget {
  final ContactObject item;
  ContactItemEdit({this.item});
  @override
  _ContactItemEditState createState() => _ContactItemEditState();
}

class _ContactItemEditState extends State<ContactItemEdit> {
  TextEditingController _firstName, _lastName, _email;
  bool _isNew = false;
  @override
  void initState() {
    _loadItemDetails();
    super.initState();
  }

  void _loadItemDetails() async {
    if ((widget?.item?.id ?? "").toString().isEmpty) {
      setState(() {
        _isNew = true;
      });
    }
    // -- Load Info --
    _firstName = TextEditingController(text: widget?.item?.firstName ?? "");
    _lastName = TextEditingController(text: widget?.item?.lastName ?? "");
  }

  void _saveInfo(BuildContext context) async {
    var uuid = new Uuid();

    if (_formKey.currentState.validate()) {
      final ContactObject _item = ContactObject(
        id: _isNew ? uuid.v4() : widget.item?.id,
        firstName: _firstName.text.toString(),
        lastName: _lastName.text.toString(),
      );

      // if (_isNew) {
      //   model.addItem(_item);
      // } else {
      //   model.editItem(_item);
      // }
      Navigator.pop(context, _item);
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final _model = ScopedModel.of<ContactModel>(context, rebuildOnChange: true);
    final String _type = ContactFields.objectType;
    return Scaffold(
      appBar: AppBar(
        title: _isNew ? Text("New $_type") : Text("Edit $_type"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              ListTile(
                title: TextFormField(
                  autofocus: true,
                  decoration:
                      InputDecoration(labelText: ContactFields.first_name),
                  controller: _firstName,
                  keyboardType: TextInputType.text,
                  validator: (val) => val.isEmpty
                      ? 'Please enter a ${ContactFields.first_name}'
                      : null,
                ),
              ),
              ListTile(
                title: TextFormField(
                  decoration:
                      InputDecoration(labelText: ContactFields.last_name),
                  controller: _lastName,
                  keyboardType: TextInputType.text,
                  validator: (val) => val.isEmpty
                      ? 'Please enter a ${ContactFields.last_name}'
                      : null,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      _isNew ? "Add $_type" : "Save $_type",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => _saveInfo(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
