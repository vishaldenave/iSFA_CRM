import 'dart:convert';

class AccountsNameModel {
  AccountsNameModel({
    required this.status,
    required this.message,
    required this.statusCode,
    required this.orgList,
  });
  late final String status;
  late final String message;
  late final int statusCode;
  late final List<OrgList> orgList;

  factory AccountsNameModel.fromRawJson(String str) =>
      AccountsNameModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  AccountsNameModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['statusCode'];
    orgList = json['orgList'] == null
        ? []
        : List.from(json['orgList']).map((e) => OrgList.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['statusCode'] = statusCode;
    data['orgList'] = orgList.map((e) => e.toJson()).toList();
    return data;
  }
}

class OrgList {
  OrgList({
    required this.orgId,
    required this.orgName,
  });
  late final String orgId;
  late final String orgName;

  OrgList.fromJson(Map<String, dynamic> json) {
    orgId = json['orgId'];
    orgName = json['orgName'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['orgId'] = orgId;
    data['orgName'] = orgName;
    return data;
  }
}
