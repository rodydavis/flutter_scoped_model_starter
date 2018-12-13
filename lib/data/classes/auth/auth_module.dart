import 'package:json_annotation/json_annotation.dart';

import '../auth/auth_user.dart';

part 'auth_module.g.dart';

@JsonSerializable()
class AuthModule {
  AuthModule({
    this.currentUser,
    this.error = "",
    this.isLoading = false,
    this.loggedIn = false,
    this.saveUsersAdded = 0,
    this.savedUsersCount = 0,
    this.userChanged = false,
    this.users,
  });

  List<AuthUser> users = [];
  AuthUser currentUser;
  bool loggedIn;
  bool userChanged;
  String error;
  bool isLoading;
  int savedUsersCount;
  int saveUsersAdded;

  factory AuthModule.fromJson(Map<String, dynamic> json) =>
      _$AuthModuleFromJson(json);

  Map<String, dynamic> toJson() => _$AuthModuleToJson(this);
}
