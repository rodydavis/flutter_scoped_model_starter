import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  Task(
      {this.leadTaskID,
      this.leadID,
      this.contactID,
      this.coreLeadID,
      this.userID,
      this.authorUserID,
      this.leadTaskType,
      this.leadTaskTitle,
      this.leadTaskDescription,
      this.leadTaskTime,
      this.taskAlertTypes,
      this.alertTimeOffset,
      this.alertLeadNumber,
      this.alertUserNumber,
      this.dismissOnChange,
      this.leadTaskStatus,
      this.taskRecur,
      this.taskRecurPattern,
      this.taskRecurEvery,
      this.taskRecurType,
      this.callSource,
      this.dateCreated,
      this.dateModified});

  String leadTaskID;
  String leadID;
  String contactID;
  String coreLeadID;
  String userID;
  String authorUserID;
  String leadTaskType;
  String leadTaskTitle;
  String leadTaskDescription;
  String leadTaskTime;
  String taskAlertTypes;
  String alertTimeOffset;
  String alertLeadNumber;
  String alertUserNumber;
  String dismissOnChange;
  String leadTaskStatus;
  String taskRecur;
  String taskRecurPattern;
  int taskRecurEvery;
  String taskRecurType;
  String callSource;
  String dateCreated;
  String dateModified;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
