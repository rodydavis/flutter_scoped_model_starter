// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactGroup _$ContactGroupFromJson(Map<String, dynamic> json) {
  return ContactGroup(
      id: json['id'] as String,
      name: json['name'] as String,
      count: json['count'] as int);
}

Map<String, dynamic> _$ContactGroupToJson(ContactGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'count': instance.count
    };
