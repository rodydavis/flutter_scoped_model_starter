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

  @JsonKey(name: 'Lead_Task_ID')
  String leadTaskID;
  @JsonKey(name: 'Lead_ID')
  String leadID;
  @JsonKey(name: 'Contact_ID')
  String contactID;
  @JsonKey(name: 'Core_Lead_ID')
  String coreLeadID;
  @JsonKey(name: 'User_ID')
  String userID;
  @JsonKey(name: 'Author_User_ID')
  String authorUserID;
  @JsonKey(name: 'Lead_Task_Type')
  String leadTaskType;
  @JsonKey(name: 'Lead_Task_Title')
  String leadTaskTitle;
  @JsonKey(name: 'Lead_Task_Description')
  String leadTaskDescription;
  @JsonKey(name: 'Lead_Task_Time')
  String leadTaskTime;
  @JsonKey(name: 'Task_Alert_Types')
  String taskAlertTypes;
  @JsonKey(name: 'Alert_Time_Offset')
  String alertTimeOffset;
  @JsonKey(name: 'Alert_Lead_Number')
  String alertLeadNumber;
  @JsonKey(name: 'Alert_User_Number')
  String alertUserNumber;
  @JsonKey(name: 'Dismiss_On_Change')
  String dismissOnChange;
  @JsonKey(name: 'Lead_Task_Status')
  String leadTaskStatus;
  @JsonKey(name: 'Task_Recur')
  String taskRecur;
  @JsonKey(name: 'Task_Recur_Pattern')
  String taskRecurPattern;
  @JsonKey(name: 'Task_Recur_Every')
  int taskRecurEvery;
  @JsonKey(name: 'Task_Recur_Type')
  String taskRecurType;
  @JsonKey(name: 'Call_Source')
  String callSource;
  @JsonKey(name: 'Date_Created')
  String dateCreated;
  @JsonKey(name: 'Date_Modified')
  String dateModified;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
