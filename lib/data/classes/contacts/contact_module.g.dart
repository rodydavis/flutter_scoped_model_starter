// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactModule _$ContactModuleFromJson(Map<String, dynamic> json) {
  return ContactModule(
      paging: json['paging'] == null
          ? null
          : Paging.fromJson(json['paging'] as Map<String, dynamic>),
      lastPage: json['lastPage'] as bool,
      contacts: (json['contacts'] as List)
          ?.map((e) =>
              e == null ? null : ContactRow.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      filtered: (json['filtered'] as List)
          ?.map((e) =>
              e == null ? null : ContactRow.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      lastUpdated: json['lastUpdated'] as int,
      isLoaded: json['isLoaded'] as bool,
      search: json['search'] == null
          ? null
          : Search.fromJson(json['search'] as Map<String, dynamic>),
      sorting: json['sorting'] == null
          ? null
          : Sort.fromJson(json['sorting'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ContactModuleToJson(ContactModule instance) =>
    <String, dynamic>{
      'paging': instance.paging,
      'lastPage': instance.lastPage,
      'contacts': instance.contacts,
      'filtered': instance.filtered,
      'isLoaded': instance.isLoaded,
      'lastUpdated': instance.lastUpdated,
      'sorting': instance.sorting,
      'search': instance.search
    };
