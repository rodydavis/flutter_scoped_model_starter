// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthInfo _$AuthInfoFromJson(Map<String, dynamic> json) {
  return AuthInfo(
      currentUser: json['currentUser'] == null
          ? null
          : User.fromJson(json['currentUser'] as Map<String, dynamic>),
      error: json['error'] as String,
      isLoading: json['isLoading'] as bool,
      loggedIn: json['loggedIn'] as bool,
      saveUsersAdded: json['saveUsersAdded'] as int,
      savedUsersCount: json['savedUsersCount'] as int,
      userChanged: json['userChanged'] as bool,
      users: (json['users'] as List)
          ?.map((e) =>
              e == null ? null : AuthUser.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$AuthInfoToJson(AuthInfo instance) => <String, dynamic>{
      'users': instance.users,
      'currentUser': instance.currentUser,
      'loggedIn': instance.loggedIn,
      'userChanged': instance.userChanged,
      'error': instance.error,
      'isLoading': instance.isLoading,
      'savedUsersCount': instance.savedUsersCount,
      'saveUsersAdded': instance.saveUsersAdded
    };
