import 'package:flutter/material.dart';
import '../app/app_input_field.dart';

class AddNotePage extends StatefulWidget {
  @override
  AddNotePageState createState() {
    return new AddNotePageState();
  }
}

class AddNotePageState extends State<AddNotePage> {
  TextEditingController _noteController;

  @override
  void initState() {
    _noteController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              NoteResult _result = NoteResult(
                note: _noteController?.text ?? "",
              );
              Navigator.pop(context, _result);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppInputField(
              autoFocus: true,
              controller: _noteController,
              required: true,
              name: "Note",
              multiLine: true,
            ),
          ],
        ),
      ),
    );
  }
}

class NoteResult {
  final String note;
  NoteResult({@required this.note});
}

Future<NoteResult> createNote(BuildContext context) async {
  var _result = await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new AddNotePage(),
        fullscreenDialog: true,
      ));
  return _result;
}
