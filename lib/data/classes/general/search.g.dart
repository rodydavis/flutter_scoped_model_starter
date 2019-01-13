// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Search _$SearchFromJson(Map<String, dynamic> json) {
  return Search(
      search: json['search'] as String,
      filters: (json['filters'] as List)?.map((e) => e as int)?.toList());
}

Map<String, dynamic> _$SearchToJson(Search instance) =>
    <String, dynamic>{'search': instance.search, 'filters': instance.filters};
