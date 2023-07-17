import 'dart:convert';

class AssignedAccountsModel {
  AssignedAccountsModel({
    required this.status,
    required this.message,
    required this.statusCode,
    required this.campaignList,
  });
  late final String status;
  late final String message;
  late final int statusCode;
  late final List<CampaignList> campaignList;

  factory AssignedAccountsModel.fromRawJson(String str) =>
      AssignedAccountsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  AssignedAccountsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['statusCode'];
    campaignList = List.from(json['campaignList'])
        .map((e) => CampaignList.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['statusCode'] = statusCode;
    data['campaignList'] = campaignList.map((e) => e.toJson()).toList();
    return data;
  }
}

class CampaignList {
  CampaignList({
    required this.campaignId,
    required this.campaignName,
    required this.campaignSubType,
    required this.campaignType,
    required this.startDate,
    required this.endDate,
  });
  late final int campaignId;
  late final String campaignName;
  late final String campaignSubType;
  late final String campaignType;
  late final String startDate;
  late final String endDate;

  factory CampaignList.fromRawJson(String str) =>
      CampaignList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  CampaignList.fromJson(Map<String, dynamic> json) {
    campaignId = json['campaignId'];
    campaignName = json['campaignName'];
    campaignSubType = json['campaignSubType'];
    campaignType = json['campaignType'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['campaignId'] = campaignId;
    data['campaignName'] = campaignName;
    data['campaignSubType'] = campaignSubType;
    data['campaignType'] = campaignType;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    return data;
  }
}
