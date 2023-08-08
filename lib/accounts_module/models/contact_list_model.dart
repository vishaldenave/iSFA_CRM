import 'dart:convert';

class ContactListModel {
  ContactListModel({
    required this.status,
    required this.message,
    required this.statusCode,
    required this.contactList,
  });
  late final String status;
  late final String message;
  late final int statusCode;
  late final List<ContactList> contactList;

  factory ContactListModel.fromRawJson(String str) =>
      ContactListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  ContactListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['statusCode'];
    contactList = List.from(json['contactList'])
        .map((e) => ContactList.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['statusCode'] = statusCode;
    data['contactList'] = contactList.map((e) => e.toJson()).toList();
    return data;
  }
}

class ContactList {
  ContactList({
    required this.orgId,
    required this.campaignId,
    required this.contactId,
    required this.contactName,
    required this.designation,
    required this.mobile,
  });
  late final String orgId;
  late final String campaignId;
  late final String? contactId;
  late final String? contactName;
  late final String? designation;
  late final String? mobile;

  ContactList.fromJson(Map<String, dynamic> json) {
    orgId = json['orgId'];
    campaignId = json['campaignId'];
    contactId = json['contactId'];
    contactName = json['contactName'];
    designation = json['designation'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['orgId'] = orgId;
    data['campaignId'] = campaignId;
    data['contactId'] = contactId;
    data['contactName'] = contactName;
    data['designation'] = designation;
    data['mobile'] = mobile;
    return data;
  }
}

class AddContactModel {
  AddContactModel({
    required this.status,
    required this.message,
    required this.statusCode,
  });
  late final String status;
  late final String message;
  late final int statusCode;

  factory AddContactModel.fromRawJson(String str) =>
      AddContactModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  AddContactModel.fromJson(Map<String, dynamic> json) {
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
