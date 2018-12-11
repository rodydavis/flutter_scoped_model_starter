import 'package:flutter/foundation.dart';

import '../data/models/auth/model.dart';

Future<bool> checkAuthorized(dynamic response,
    {@required AuthModel auth}) async {
  if (response['Message'] ==
      "Authorization has been denied for this request.") {
    await auth.refreshToken();
    return false;
  }
  return true;
}