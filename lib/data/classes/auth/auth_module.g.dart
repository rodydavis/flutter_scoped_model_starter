// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModule _$AuthModuleFromJson(Map<String, dynamic> json) {
  return AuthModule(
      currentUser: json['currentUser'] == null
          ? null
          : AuthUser.fromJson(json['currentUser'] as Map<String, dynamic>),
      error: json['error'] as String,
      loggedIn: json['loggedIn'] as bool,
      users: (json['users'] as List)
          ?.map((e) =>
              e == null ? null : AuthUser.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$AuthModuleToJson(AuthModule instance) =>
    <String, dynamic>{
      'users': instance.users,
      'currentUser': instance.currentUser,
      'loggedIn': instance.loggedIn,
      'error': instance.error
    };
