// import 'package:app_review/app_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
// import 'package:get_version/get_version.dart';

import '../../data/local_storage.dart';
import '../../utils/phoneCall.dart';
import '../../utils/sendEmail.dart';
import '../../constants.dart';
import '../../utils/url.dart';

// Stateful widget for managing name data
class SupportPage extends StatefulWidget {
  static String routeName = "/help";

  @override
  _SupportPageState createState() => _SupportPageState();
}

// State for managing fetching name data over HTTPP>
class _SupportPageState extends State<SupportPage> {
  String _platformVersion = 'Unknown';
  String _projectVersion = 'Unknown';
  String _projectCode = 'Unknown';

  @override
  initState() {
    super.initState();
    initPlatformState();
    // AppReview.getAppID.then((onValue) {
    //   print('App ID: ' + onValue);
    // });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    // String projectVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // try {
    //   projectVersion = await GetVersion.projectVersion;
    // } on PlatformException {
    //   projectVersion = 'Failed to get platform version.';
    // }

    // String projectCode;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // try {
    //   projectCode = await GetVersion.projectCode;
    // } on PlatformException {
    //   projectCode = 'Failed to get platform version.';
    // }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = Platform.operatingSystem;
      _projectVersion = "1.0.0";
      _projectCode = "1";
    });
  }

  String supportEmail = 'support@crossmedia-llc.com';
  String supportPhone = '866-497-3224';
  String supportWeb = 'http://unifycrm.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Help",
          textScaleFactor: textScaleFactor,
        ),
      ),
      body: SingleChildScrollView(
          child: SafeArea(
        child: ListBody(
          children: <Widget>[
            Container(
              height: 10.0,
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text(
                'Email Support',
                textScaleFactor: textScaleFactor,
              ),
              subtitle: Text(
                supportEmail,
                textScaleFactor: textScaleFactor,
              ),
              onTap: () async {
                // Todo: Finish Support
                // var _prefs = AppPreferences();
                // var _domain = await _prefs.getValue(Info.domain);
                // var newLine = "\n\n";
                // String _message = 'Version: $_projectVersion ($_projectCode)' +
                //     newLine +
                //     'Running on: $_platformVersion' +
                //     newLine +
                //     'User: ${widget.model.user?.firstName} ${widget.model.user?.lastName}' +
                //     newLine +
                //     'Company Domain: $_domain' +
                //     newLine;
                // sendEmail(context,
                //     recipients: [supportEmail],
                //     subject: 'Support needed for Unify Mobile',
                //     body: _message,
                //     bcc: supportEmails);
              },
            ),
            Divider(
              height: 20.0,
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text(
                'Call Support',
                textScaleFactor: textScaleFactor,
              ),
              subtitle: Text(
                supportPhone,
                textScaleFactor: textScaleFactor,
              ),
              onTap: () => makePhoneCall(context, supportPhone),
            ),
            Divider(
              height: 20.0,
            ),
            ListTile(
              leading: Icon(Icons.web),
              title: Text(
                'Website',
                textScaleFactor: textScaleFactor,
              ),
              subtitle: Text(
                supportWeb,
                textScaleFactor: textScaleFactor,
              ),
              onTap: () {
                launchURL(supportWeb);
              },
            ),
            Divider(
              height: 20.0,
            ),
            ListTile(
              leading: Icon(Icons.rate_review),
              title: Text(
                'Rating',
                textScaleFactor: textScaleFactor,
              ),
              subtitle: Text(
                'Write a Review',
                textScaleFactor: textScaleFactor,
              ),
              onTap: () {
                // AppReview.writeReview.then((onValue) {
                //   print(onValue);
                // });
              },
            ),
            Divider(
              height: 20.0,
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text(
                'Version',
                textScaleFactor: textScaleFactor,
              ),
              subtitle: Text(
                '$_projectVersion ($_projectCode)',
                textScaleFactor: textScaleFactor,
              ),
              trailing: Text(
                '$_platformVersion',
                textScaleFactor: textScaleFactor,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
