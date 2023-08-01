import 'dart:convert';

class CallStatusModel {
  CallStatusModel({
    required this.status,
    required this.message,
    required this.statusCode,
    required this.callStatusList,
  });
  late final String status;
  late final String message;
  late final int statusCode;
  late final List<String> callStatusList;

  factory CallStatusModel.fromRawJson(String str) =>
      CallStatusModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  CallStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['statusCode'];
    callStatusList = List.castFrom<dynamic, String>(json['callStatusList']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['statusCode'] = statusCode;
    data['callStatusList'] = callStatusList;
    return data;
  }
}

class ContactStatusModel {
  ContactStatusModel({
    required this.status,
    required this.message,
    required this.statusCode,
    required this.contactStatusList,
  });
  late final String status;
  late final String message;
  late final int statusCode;
  late final List<ContactStatusList> contactStatusList;

  factory ContactStatusModel.fromRawJson(String str) =>
      ContactStatusModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  ContactStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['statusCode'];
    contactStatusList = List.from(json['contactStatusList'])
        .map((e) => ContactStatusList.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['statusCode'] = statusCode;
    data['contactStatusList'] =
        contactStatusList.map((e) => e.toJson()).toList();
    return data;
  }
}

class ContactStatusList {
  ContactStatusList({
    required this.id,
    required this.contactStatus,
  });
  late final int id;
  late final String contactStatus;

  ContactStatusList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contactStatus = json['contactStatus'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['contactStatus'] = contactStatus;
    return data;
  }
}

class CallSubStatusModel {
  CallSubStatusModel({
    required this.status,
    required this.message,
    required this.statusCode,
    required this.contactSubStatusList,
  });
  late final String status;
  late final String message;
  late final int statusCode;
  late final List<String> contactSubStatusList;

  factory CallSubStatusModel.fromRawJson(String str) =>
      CallSubStatusModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  CallSubStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['statusCode'];
    contactSubStatusList =
        List.castFrom<dynamic, String>(json['contactSubStatusList']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['statusCode'] = statusCode;
    data['contactSubStatusList'] = contactSubStatusList;
    return data;
  }
}

class CallFeedbackModel {
  CallFeedbackModel({
    required this.userId,
    required this.campaignId,
    required this.orgId,
    required this.sessionId,
    required this.contactId,
    required this.contactStatus,
    required this.callStatus,
    required this.contactSubStatus,
    required this.remarks,
    required this.callDuration,
    required this.callerId,
  });
  late final String userId;
  late final String campaignId;
  late final String orgId;
  late final String sessionId;
  late final String contactId;
  late final String contactStatus;
  late final String callStatus;
  late final String contactSubStatus;
  late final String remarks;
  late final String callDuration;
  late final String callerId;

  factory CallFeedbackModel.fromRawJson(String str) =>
      CallFeedbackModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  CallFeedbackModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    campaignId = json['campaignId'];
    orgId = json['orgId'];
    sessionId = json['sessionId'];
    contactId = json['contactId'];
    contactStatus = json['contactStatus'];
    callStatus = json['callStatus'];
    contactSubStatus = json['contactSubStatus'];
    remarks = json['remarks'];
    callDuration = json['callDuration'];
    callerId = json['callerId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['campaignId'] = campaignId;
    data['orgId'] = orgId;
    data['sessionId'] = sessionId;
    data['contactId'] = contactId;
    data['contactStatus'] = contactStatus;
    data['callStatus'] = callStatus;
    data['contactSubStatus'] = contactSubStatus;
    data['remarks'] = remarks;
    data['callDuration'] = callDuration;
    data['callerId'] = callerId;
    return data;
  }
}

class CallFeedbackBodyModel {
  CallFeedbackBodyModel({
    required this.status,
    required this.message,
    required this.statusCode,
  });
  late final String status;
  late final String message;
  late final int statusCode;

  factory CallFeedbackBodyModel.fromRawJson(String str) =>
      CallFeedbackBodyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  CallFeedbackBodyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['statusCode'] = statusCode;
    return data;
  }
}
