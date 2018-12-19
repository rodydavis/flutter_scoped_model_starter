import 'package:flutter/material.dart';
import '../../../data/classes/unify/contact_group.dart';
import '../../../data/models/contacts/list.dart';
import '../../../data/models/contacts/groups.dart';
import 'package:scoped_model/scoped_model.dart';

class EditContactGroup extends StatefulWidget {
  final bool isNew;
  final ContactGroup group;
//  final VoidCallback groupDeleted;
  final ContactGroupModel groupModel;
  EditContactGroup({
    this.isNew,
    this.groupModel,
    this.group,
//    this.groupDeleted,
  });

  @override
  EditContactGroupState createState() {
    return new EditContactGroupState();
  }
}

class EditContactGroupState extends State<EditContactGroup> {
  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  TextEditingController _nameController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameController = TextEditingController(
      text: widget?.group?.name ?? "",
    );
    // setState(() {});
    super.initState();
  }

  void _saveInfo(BuildContext context) {
    if (_formKey.currentState.validate()) {
      // -- Save Info --
      final _name = _nameController?.text ?? "";
      final ContactGroup _group =
          ContactGroup(id: widget?.group?.id ?? "", name: _name);
      Navigator.pop(context, _group);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ContactGroupModel>(
        model: widget.groupModel,
        child: Scaffold(
          appBar: AppBar(
            title:
                Text(widget.isNew ? "Add Contact Group" : "Edit Contact Group"),
            actions: widget.isNew
                ? null
                : <Widget>[
                    new ScopedModelDescendant<ContactGroupModel>(
                        builder: (context, child, model) => model.fetching
                            ? Container(
                                height: 48.0,
                                child: CircularProgressIndicator(),
                              )
                            : IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: widget.group?.count == 0
                                    ? null
                                    : () async {
                                        await model.deleteContactGroup(
                                            id: widget?.group?.id);
                                        if (model.success)
                                          Navigator.pop(context, true);
                                      },
                              )),
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
        ));
  }
}

void createGroup(BuildContext context, {@required ContactModel model}) {
  Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new EditContactGroup(
              isNew: true,
              groupModel: ContactGroupModel(auth: model?.auth),
            ),
        fullscreenDialog: true,
      ));
}

void editGroup(BuildContext context,
    {@required ContactGroup group, @required ContactModel model}) {
  Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new EditContactGroup(
            groupModel: ContactGroupModel(auth: model?.auth, id: group?.id),
            isNew: false,
            group: group),
        fullscreenDialog: true,
      ));
}
