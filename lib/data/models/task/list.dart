class TaskResult {
  String status;
  String message;
  List<Task> result;

  TaskResult({this.status, this.message, this.result});

  TaskResult.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    if (json['Result'] != null) {
      result = new List<Task>();
      json['Result'].forEach((v) {
        result.add(new Task.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.result != null) {
      data['Result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Task {
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

  Task.fromJson(Map<String, dynamic> json) {
    leadTaskID = json['Lead_Task_ID'];
    leadID = json['Lead_ID'];
    contactID = json['Contact_ID'];
    coreLeadID = json['Core_Lead_ID'];
    userID = json['User_ID'];
    authorUserID = json['Author_User_ID'];
    leadTaskType = json['Lead_Task_Type'];
    leadTaskTitle = json['Lead_Task_Title'];
    leadTaskDescription = json['Lead_Task_Description'];
    leadTaskTime = json['Lead_Task_Time'];
    taskAlertTypes = json['Task_Alert_Types'];
    alertTimeOffset = json['Alert_Time_Offset'];
    alertLeadNumber = json['Alert_Lead_Number'];
    alertUserNumber = json['Alert_User_Number'];
    dismissOnChange = json['Dismiss_On_Change'];
    leadTaskStatus = json['Lead_Task_Status'];
    taskRecur = json['Task_Recur'];
    taskRecurPattern = json['Task_Recur_Pattern'];
    taskRecurEvery = json['Task_Recur_Every'];
    taskRecurType = json['Task_Recur_Type'];
    callSource = json['Call_Source'];
    dateCreated = json['Date_Created'];
    dateModified = json['Date_Modified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Lead_Task_ID'] = this.leadTaskID;
    data['Lead_ID'] = this.leadID;
    data['Contact_ID'] = this.contactID;
    data['Core_Lead_ID'] = this.coreLeadID;
    data['User_ID'] = this.userID;
    data['Author_User_ID'] = this.authorUserID;
    data['Lead_Task_Type'] = this.leadTaskType;
    data['Lead_Task_Title'] = this.leadTaskTitle;
    data['Lead_Task_Description'] = this.leadTaskDescription;
    data['Lead_Task_Time'] = this.leadTaskTime;
    data['Task_Alert_Types'] = this.taskAlertTypes;
    data['Alert_Time_Offset'] = this.alertTimeOffset;
    data['Alert_Lead_Number'] = this.alertLeadNumber;
    data['Alert_User_Number'] = this.alertUserNumber;
    data['Dismiss_On_Change'] = this.dismissOnChange;
    data['Lead_Task_Status'] = this.leadTaskStatus;
    data['Task_Recur'] = this.taskRecur;
    data['Task_Recur_Pattern'] = this.taskRecurPattern;
    data['Task_Recur_Every'] = this.taskRecurEvery;
    data['Task_Recur_Type'] = this.taskRecurType;
    data['Call_Source'] = this.callSource;
    data['Date_Created'] = this.dateCreated;
    data['Date_Modified'] = this.dateModified;
    return data;
  }
}