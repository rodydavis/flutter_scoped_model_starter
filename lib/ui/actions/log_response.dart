import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app/app_input_field.dart';
import '../app/app_selection_field.dart';

enum LogResponseType { contact, lead }

class LogResponsePage extends StatefulWidget {
  final LogResponseType type;

  LogResponsePage({
    this.type = LogResponseType.contact,
  });

  @override
  LogResponsePageState createState() {
    return new LogResponsePageState();
  }
}

class LogResponsePageState extends State<LogResponsePage> {
  TextEditingController _responseController;
  String selection = "";
  List<String> responses;

  @override
  void initState() {
    super.initState();
    _responseController = TextEditingController();

    if (widget.type == LogResponseType.contact) {
      responses = responsesContact;
    } else {
      responses = responsesLead;
    }
    setState(() {
      selection = responses.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool _showIos = false;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Log Response"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              LogResponseResult _result = LogResponseResult(
                response: selection,
                comment: _responseController?.text ?? "",
              );
              Navigator.pop(context, _result);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(height: 10.0),
            AppInputSelection(
//              showMaterial: true,
              label: "Select a Response",
              selection: selection,
              items: responses,
              onSelected: (String value) {
                setState(() {
                  selection = value;
                });
              },
            ),
            AppInputField(
              autoFocus: true,
              controller: _responseController,
              name: "Comments",
              multiLine: true,
            ),
          ],
        ),
      ),
    );
  }
}

const List<String> responsesContact = [
  "Called and Spoke - Great Call",
  "Called and Spoke - General",
  "Called Left Message",
  "Called No Answer",
  "General Comment",
  "Face to Face",
  "Break Bread"
];

const List<String> responsesLead = [
  "No Contact Left Message",
  "No Contact Emailed Only",
  "No Contact Nurture",
  "Contacted Set Appointment",
  "Contacted Quoted",
  "Contacted Nurture",
  "Application Received",
  "Application Disclosures Sent",
  "Application Prequal",
  "Application in Process",
  "Inactive Borrower Not Interested",
  "Inactive DNQ Property",
  "Inactive DNQ Borrower",
  "Inactive Withdrawn",
  "Inactive DNQ Borrower",
  "Bad Lead Return To Vendor",
  "General Comment"
];

class LogResponseResult {
  final String comment, response;
  LogResponseResult({this.comment, @required this.response});
}

Future<LogResponseResult> createLogResponse(BuildContext context) async {
  var _result = await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new LogResponsePage(),
        fullscreenDialog: true,
      ));
  return _result;
}
