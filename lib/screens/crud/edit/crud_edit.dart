import 'package:flutter/material.dart';

import '../../../data/models/crud_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uuid/uuid.dart';

class CRUDItemEdit extends StatefulWidget {
  final CRUDObject item;
  CRUDItemEdit({this.item});
  @override
  _CRUDItemEditState createState() => _CRUDItemEditState();
}

class _CRUDItemEditState extends State<CRUDItemEdit> {
  TextEditingController _nameController, _descriptionController;
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
    _nameController = TextEditingController(text: widget?.item?.name ?? "");
    _descriptionController =
        TextEditingController(text: widget?.item?.description ?? "");
  }

  void _saveInfo(BuildContext context) async {
    var uuid = new Uuid();

    if (_formKey.currentState.validate()) {
      // - Get info From Input --
      var _name = _nameController.text.toString();
      var _description = _descriptionController.text.toString();

      final CRUDObject _item = CRUDObject(
        id: _isNew ? uuid.v4() : widget.item?.id,
        name: _name,
        description: _description,
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
    // final _model = ScopedModel.of<CRUDModel>(context, rebuildOnChange: true);
    return Scaffold(
      appBar: AppBar(
        title: _isNew ? Text("New Item") : Text("Edit Item"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              ListTile(
                title: TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(labelText: "Name"),
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  validator: (val) =>
                      val.isEmpty ? 'Please enter a name' : null,
                ),
              ),
              ListTile(
                title: TextFormField(
                  decoration: InputDecoration(labelText: "Description"),
                  controller: _descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  // validator: (val) =>
                  //     val.isEmpty ? 'Please enter a description' : null,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      _isNew ? "Add Item" : "Save Item",
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
