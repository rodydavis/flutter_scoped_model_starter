import 'package:flutter/material.dart';
import '../../../data/classes/unify/contact_group.dart';

class EditContactGroup extends StatefulWidget {
  final bool isNew;
  final String groupName, id;
  final VoidCallback groupDeleted;
  EditContactGroup({
    this.isNew,
    this.id,
    this.groupName,
    this.groupDeleted,
  });

  @override
  EditContactGroupState createState() {
    return new EditContactGroupState();
  }
}

class EditContactGroupState extends State<EditContactGroup> {
  TextEditingController _nameController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameController = TextEditingController(
      text: widget?.groupName ?? "",
    );
    // setState(() {});
    super.initState();
  }

  void _saveInfo(BuildContext context) {
    if (_formKey.currentState.validate()) {
      // -- Save Info --
      final _name = _nameController?.text ?? "";
      final ContactGroup _group =
          ContactGroup(id: widget?.id ?? "", name: _name);
      Navigator.pop(context, _group);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isNew ? "Add Contact Group" : "Edit Contact Group"),
        actions: widget.isNew
            ? null
            : <Widget>[
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    widget.groupDeleted();
                    Navigator.pop(context);
                  },
                ),
              ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(labelText: "Group Name"),
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a Group Name' : null,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        widget.isNew ? "Add Group" : "Save Group",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => _saveInfo(context),
                    ),
                  ],
                ),
                Container(height: 50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
