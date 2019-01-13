import 'package:json_annotation/json_annotation.dart';

import '../user/user.dart';

part 'auth_user.g.dart';

@JsonSerializable()
class AuthUser {
  AuthUser({
    this.token = "",
    this.data,
    this.username,
    this.password,
    this.tokenExpiration = 0,
  });

  String username, password, token;
  User data;
  int tokenExpiration;

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserToJson(this);
}
