// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
      leadTaskID: json['Lead_Task_ID'] as String,
      leadID: json['Lead_ID'] as String,
      contactID: json['Contact_ID'] as String,
      coreLeadID: json['Core_Lead_ID'] as String,
      userID: json['User_ID'] as String,
      authorUserID: json['Author_User_ID'] as String,
      leadTaskType: json['Lead_Task_Type'] as String,
      leadTaskTitle: json['Lead_Task_Title'] as String,
      leadTaskDescription: json['Lead_Task_Description'] as String,
      leadTaskTime: json['Lead_Task_Time'] as String,
      taskAlertTypes: json['Task_Alert_Types'] as String,
      alertTimeOffset: json['Alert_Time_Offset'] as String,
      alertLeadNumber: json['Alert_Lead_Number'] as String,
      alertUserNumber: json['Alert_User_Number'] as String,
      dismissOnChange: json['Dismiss_On_Change'] as String,
      leadTaskStatus: json['Lead_Task_Status'] as String,
      taskRecur: json['Task_Recur'] as String,
      taskRecurPattern: json['Task_Recur_Pattern'] as String,
      taskRecurEvery: json['Task_Recur_Every'] as int,
      taskRecurType: json['Task_Recur_Type'] as String,
      callSource: json['Call_Source'] as String,
      dateCreated: json['Date_Created'] as String,
      dateModified: json['Date_Modified'] as String);
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'Lead_Task_ID': instance.leadTaskID,
      'Lead_ID': instance.leadID,
      'Contact_ID': instance.contactID,
      'Core_Lead_ID': instance.coreLeadID,
      'User_ID': instance.userID,
      'Author_User_ID': instance.authorUserID,
      'Lead_Task_Type': instance.leadTaskType,
      'Lead_Task_Title': instance.leadTaskTitle,
      'Lead_Task_Description': instance.leadTaskDescription,
      'Lead_Task_Time': instance.leadTaskTime,
      'Task_Alert_Types': instance.taskAlertTypes,
      'Alert_Time_Offset': instance.alertTimeOffset,
      'Alert_Lead_Number': instance.alertLeadNumber,
      'Alert_User_Number': instance.alertUserNumber,
      'Dismiss_On_Change': instance.dismissOnChange,
      'Lead_Task_Status': instance.leadTaskStatus,
      'Task_Recur': instance.taskRecur,
      'Task_Recur_Pattern': instance.taskRecurPattern,
      'Task_Recur_Every': instance.taskRecurEvery,
      'Task_Recur_Type': instance.taskRecurType,
      'Call_Source': instance.callSource,
      'Date_Created': instance.dateCreated,
      'Date_Modified': instance.dateModified
    };
