import 'dart:async';

import '../../constants.dart';
import '../models/auth/info.dart';
import '../web_client.dart';

class AuthRepository {
  final WebClient webClient;

  const AuthRepository({
    this.webClient = const WebClient(),
  });

  Future<String> login(String email, String password) async {
    final credentials = {
      'grant_type': 'password',
      'username': email,
      'password': password,
    };

    var url = kApiUrl.replaceAll('api', 'token');

    final response = await webClient.post(
      url,
      credentials,
      bodyContentType: "application/x-www-form-urlencoded",
    );

    return response['access_token'];
  }

  Future<UserInfoResult> getInfo(String token) async {
    dynamic _response;
    final response = await webClient.get(
      kApiUrl + '/account/info',
      token: token,
    );
    _response = response;
    var _user = UserInfo.fromJson(_response).result;
    return _user;
  }
}
