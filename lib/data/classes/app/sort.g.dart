// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sort _$SortFromJson(Map<String, dynamic> json) {
  return Sort(
      fields: (json['fields'] as List)?.map((e) => e as String)?.toList(),
      ascending: json['ascending'] as bool,
      field: json['field'] as String,
      initialized: json['initialized'] as bool);
}

Map<String, dynamic> _$SortToJson(Sort instance) => <String, dynamic>{
      'fields': instance.fields,
      'ascending': instance.ascending,
      'field': instance.field,
      'initialized': instance.initialized
    };
