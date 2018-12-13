// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
      leadTaskID: json['leadTaskID'] as String,
      leadID: json['leadID'] as String,
      contactID: json['contactID'] as String,
      coreLeadID: json['coreLeadID'] as String,
      userID: json['userID'] as String,
      authorUserID: json['authorUserID'] as String,
      leadTaskType: json['leadTaskType'] as String,
      leadTaskTitle: json['leadTaskTitle'] as String,
      leadTaskDescription: json['leadTaskDescription'] as String,
      leadTaskTime: json['leadTaskTime'] as String,
      taskAlertTypes: json['taskAlertTypes'] as String,
      alertTimeOffset: json['alertTimeOffset'] as String,
      alertLeadNumber: json['alertLeadNumber'] as String,
      alertUserNumber: json['alertUserNumber'] as String,
      dismissOnChange: json['dismissOnChange'] as String,
      leadTaskStatus: json['leadTaskStatus'] as String,
      taskRecur: json['taskRecur'] as String,
      taskRecurPattern: json['taskRecurPattern'] as String,
      taskRecurEvery: json['taskRecurEvery'] as int,
      taskRecurType: json['taskRecurType'] as String,
      callSource: json['callSource'] as String,
      dateCreated: json['dateCreated'] as String,
      dateModified: json['dateModified'] as String);
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'leadTaskID': instance.leadTaskID,
      'leadID': instance.leadID,
      'contactID': instance.contactID,
      'coreLeadID': instance.coreLeadID,
      'userID': instance.userID,
      'authorUserID': instance.authorUserID,
      'leadTaskType': instance.leadTaskType,
      'leadTaskTitle': instance.leadTaskTitle,
      'leadTaskDescription': instance.leadTaskDescription,
      'leadTaskTime': instance.leadTaskTime,
      'taskAlertTypes': instance.taskAlertTypes,
      'alertTimeOffset': instance.alertTimeOffset,
      'alertLeadNumber': instance.alertLeadNumber,
      'alertUserNumber': instance.alertUserNumber,
      'dismissOnChange': instance.dismissOnChange,
      'leadTaskStatus': instance.leadTaskStatus,
      'taskRecur': instance.taskRecur,
      'taskRecurPattern': instance.taskRecurPattern,
      'taskRecurEvery': instance.taskRecurEvery,
      'taskRecurType': instance.taskRecurType,
      'callSource': instance.callSource,
      'dateCreated': instance.dateCreated,
      'dateModified': instance.dateModified
    };
