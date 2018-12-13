// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paging.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Paging _$PagingFromJson(Map<String, dynamic> json) {
  return Paging(rows: json['rows'] as int, page: json['page'] as int);
}

Map<String, dynamic> _$PagingToJson(Paging instance) =>
    <String, dynamic>{'rows': instance.rows, 'page': instance.page};
