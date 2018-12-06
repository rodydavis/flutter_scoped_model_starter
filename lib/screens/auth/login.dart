import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/local_storage.dart';
import '../../data/models/auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController, _passwordController;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _initPlatformState();
    super.initState();
  }

  void _initPlatformState() async {
    var prefs = AppPreferences();
    var _username = await prefs.getInfo(Info.username);
    setState(() {
      _usernameController = TextEditingController(text: _username);
    });
  }

  void _login(BuildContext context, {@required AuthModel user}) {
    if (_formKey.currentState.validate()) {
      // - Get info From Input --
      var _username = _usernameController.text.toLowerCase().toString();
      var _password = _passwordController.text.toString();

      // -- Login --
      user.login(username: _username, password: _password).then((_) {
        if (user?.loggedIn ?? false) {
          Navigator.pushReplacementNamed(context, "/home");
        }
      });
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _user = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
          child: Form(
        // autovalidate: true,
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: TextFormField(
                decoration: InputDecoration(labelText: "Username"),
                controller: _usernameController,
                keyboardType: TextInputType.emailAddress,
                validator: (val) =>
                    val.isEmpty ? 'Please enter a username' : null,
              ),
            ),
            ListTile(
              title: TextFormField(
                decoration: InputDecoration(labelText: "Password"),
                controller: _passwordController,
                obscureText: true,
                keyboardType: TextInputType.text,
                validator: (val) =>
                    val.isEmpty ? 'Please enter a password' : null,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => _login(context, user: _user),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
