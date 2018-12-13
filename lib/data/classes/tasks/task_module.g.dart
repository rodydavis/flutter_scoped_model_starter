// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModule _$TaskModuleFromJson(Map<String, dynamic> json) {
  return TaskModule(
      isLoaded: json['isLoaded'] as bool,
      lastUpdated: json['lastUpdated'] as int,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      tasks: (json['tasks'] as List)
          ?.map((e) =>
              e == null ? null : Task.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$TaskModuleToJson(TaskModule instance) =>
    <String, dynamic>{
      'isLoaded': instance.isLoaded,
      'lastUpdated': instance.lastUpdated,
      'date': instance.date?.toIso8601String(),
      'tasks': instance.tasks
    };
