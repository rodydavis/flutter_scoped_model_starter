import 'package:json_annotation/json_annotation.dart';

import '../auth/auth_user.dart';

part 'auth_module.g.dart';

@JsonSerializable()
class AuthModule {
  AuthModule({
    this.currentUser,
    this.error = "",
    this.loggedIn = false,
    this.users,
  });

  List<AuthUser> users = [];
  AuthUser currentUser;
  bool loggedIn;
  String error;

  factory AuthModule.fromJson(Map<String, dynamic> json) =>
      _$AuthModuleFromJson(json);

  Map<String, dynamic> toJson() => _$AuthModuleToJson(this);
}
