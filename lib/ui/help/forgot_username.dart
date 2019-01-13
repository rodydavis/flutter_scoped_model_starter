import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../utils/phoneCall.dart';

//Forgot Other
// Stateful widget for managing name data
class ForgotOtherPage extends StatelessWidget {
  final String supportPhone = '651-426-6696';
  static String routeName = "/forgot_username";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Help",
          textScaleFactor: textScaleFactor,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Container(
                height: 10.0,
              ),
              ListTile(
                leading: Icon(Icons.info),
                subtitle: Text(
                    'Please call Cross Media LLC at 651-426-6696 from 8:30 AM to 5:00 PM CDT for further assistance.'),
              ),
              Divider(
                height: 20.0,
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: const Text('Call Support'),
                subtitle: Text('651-426-6696'),
                onTap: () => makePhoneCall(context, supportPhone),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
