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
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['statusCode'] = statusCode;
    _data['contactStatusList'] =
        contactStatusList.map((e) => e.toJson()).toList();
    return _data;
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
