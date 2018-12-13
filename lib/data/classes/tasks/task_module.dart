import 'package:json_annotation/json_annotation.dart';

import 'task.dart';

part 'task_module.g.dart';

@JsonSerializable()
class TaskModule {
  TaskModule({
    this.isLoaded = false,
    this.lastUpdated = 0,
    this.date,
    this.tasks,
  });

  bool isLoaded;
  int lastUpdated;
  DateTime date;
  List<Task> tasks;

  factory TaskModule.fromJson(Map<String, dynamic> json) =>
      _$TaskModuleFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModuleToJson(this);
}
