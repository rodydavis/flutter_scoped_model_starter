import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:native_widgets/native_widgets.dart';

import '../../data/local_storage.dart';
import '../../utils/popUp.dart';
import '../../constants.dart';
import 'forgot_username.dart';

// Stateful widget for managing name data
class ForgotPasswordPage extends StatefulWidget {
  static String routeName = "/forgot_password";
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

// State for managing fetching name data over HTTP
class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  String _domain, _username;
  bool error = false;

  @override
  initState() {
    _getInfo();
    super.initState();
  }

  Future _getInfo() async {
    var _prefs = AppPreferences();
    _username = await _prefs.getInfo(Info.username);
    _domain = await _prefs.getInfo(Info.domain);
  }

  Future<Null> _submit() async {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      String result = "";
      result = await getData("get", "login", "forgotpassword", _username, "");
      print('Result: $result');
      if (error) {
        showAlertPopup(context, "Info", "Please Try Again!\n" + result);
      } else {
        showAlertPopup(context, 'Info',
            'Your Password has been reset, please check your email.');
      }
    }
  }

  Future<String> getData(String calltypeParm, String modParm, String actionParm,
      String paramsParm, String fooParm) async {
    var requestURL = "https://" + _domain + "/API/Mobile/get_json_data.aspx?";
    requestURL = requestURL + "calltype=" + calltypeParm;
    requestURL = requestURL + "&mod=" + modParm;
    requestURL = requestURL + "&?action=" + actionParm;
    requestURL = requestURL + "&?param=" + paramsParm;
    requestURL = requestURL + "&?foo=" + fooParm;
    print("Request URL: " + requestURL);

    var url = requestURL;
    var httpClient = HttpClient();
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    String result;
    error = false;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        try {
          var json = await response.transform(utf8.decoder).join();
          result = json;
        } catch (exception) {
          result = '';
          error = true;
          return 'Error Getting Data\n\n$exception';
        }
      } else {
        result = '';
        error = true;
        return 'Error getting IP address\n\nHttp status ${response.statusCode}';
      }
    } catch (exception) {
      result = '';
      error = true;
      return 'Check Unify Domain!\n\n$exception';
    }
    print("Result: " + result);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Forgot Password",
          textScaleFactor: textScaleFactor,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Container(
                height: 20.0,
              ),
              ListTile(
                leading: Icon(Icons.info),
                // title: const Text('Email Support'),
                subtitle: Text(
                  'Fill in your Unify Username and Unify Domain.\nClick Submit and your Password will be emailed to you.',
                ),
              ),
              Divider(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Username'),
                        validator: (val) =>
                            val.length < 1 ? 'Username Required' : null,
                        onSaved: (val) => _username = val,
                        obscureText: false,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Unify Domain'),
                        validator: (val) =>
                            val.length < 1 ? 'Domain Required' : null,
                        onSaved: (val) => _domain = val,
                        obscureText: false,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 10.0,
              ),
              NativeButton(
                child: Text(
                  'Submit',
                  textScaleFactor: textScaleFactor,
                ),
                buttonColor: Colors.blue,
                paddingExternal: const EdgeInsets.all(10.0),
                onPressed: _submit,
              ),
              Divider(
                height: 10.0,
              ),
              NativeButton(
                child: Text(
                  'Forgot Username or Unify Domain?',
                  textScaleFactor: textScaleFactor,
                ),
                paddingExternal: const EdgeInsets.all(10.0),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotOtherPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
