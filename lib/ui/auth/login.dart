import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../constants.dart';
import '../../data/models/app_model.dart';
import '../help/forgot_password.dart';
import '../../main.dart';

class LoginPage extends StatefulWidget {
  final bool addUser;
  final String username;
  LoginPage({this.addUser = false, this.username = ""});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController, _passwordController;
  String _error = "";
  bool _hidePassword = true;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _initPlatformState();
    super.initState();
  }

  void _initPlatformState() async {
    setState(() {
      _usernameController = TextEditingController(text: widget.username);
    });
  }

  void _login(BuildContext context, {@required AppState app}) {
    if (_formKey.currentState.validate()) {
      // - Get info From Input --
      var _username = _usernameController.text.toLowerCase().toString();
      var _password = _passwordController.text.toString();

      // -- Login --
      authModel.login(username: _username, password: _password).then((valid) {
        if (valid) {
          if (widget.addUser) {
            Navigator.pop(context);
          } else {
            Navigator.pushReplacementNamed(context, "/home");
          }
        } else {
          setState(() {
            // _error = user.error;
            _error = "Username or Password Incorrect";
          });
        }
      });
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _app = ScopedModel.of<AppState>(context, rebuildOnChange: true);
    return Scaffold(
        appBar: widget.addUser
            ? AppBar(
                title: Text("Login"),
              )
            : null,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Form(
          // autovalidate: true,
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
//              Container(
//                height: 220.0,
//                // width: 220.0,
//                child: Padding(
//                    padding: EdgeInsets.all(16.0),
//                    child: Image.asset(
//                      Theme.of(context).brightness == Brightness.dark
//                          ? kLogoDark
//                          : kLogoLight,
//                      // fit: BoxFit.fitWidth,
//                    )),
//              ),
              ListTile(
                title: TextFormField(
                  autofocus: true,
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
                  obscureText: _hidePassword,
                  keyboardType: TextInputType.text,
                  validator: (val) =>
                      val.isEmpty ? 'Please enter a password' : null,
                ),
                trailing: IconButton(
                  icon: Icon(
                      _hidePassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },
                ),
              ),
              Container(height: 30.0),

              ListTile(
                title: authModel.fetching
                    ? InkWell(
                        onTap: () => authModel.cancel(),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () => _login(context, app: _app),
                      ),
              ),
              ListTile(
                title: FlatButton(
                  child: Text("Trouble Logging In?"),
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage(),
                            fullscreenDialog: true),
                      ),
                ),
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: <Widget>[
              //     FlatButton(
              //       child: Text("Create Account"),
              //       onPressed: () => Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => CreateAccountPage(),
              //                 fullscreenDialog: true),
              //           ),
              //     ),
              //   ],
              // ),
              _error.toString().isEmpty
                  ? Container()
                  : ListTile(
                      title: Text(
                      _error,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red),
                    )),
            ],
          ),
        ))));
  }
}
