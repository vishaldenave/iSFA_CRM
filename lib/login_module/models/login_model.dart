import 'dart:convert';

class LoginModel {
  LoginModel({
    required this.status,
    required this.message,
    required this.statusCode,
    required this.userId,
    required this.sessionId,
    required this.campaignId,
    required this.role,
    required this.username,
    required this.teamLeader,
    required this.programManager,
  });
  late final String status;
  late final String message;
  late final int statusCode;
  late final String userId;
  late final String sessionId;
  late final int campaignId;
  late final String role;
  late final String username;
  late final String teamLeader;
  late final String programManager;

  factory LoginModel.fromRawJson(String str) =>
      LoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['statusCode'];
    userId = json['userId'];
    sessionId = json['sessionId'];
    campaignId = json['campaignId'];
    role = json['role'];
    username = json['username'];
    teamLeader = json['teamLeader'];
    programManager = json['programManager'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['statusCode'] = statusCode;
    data['userId'] = userId;
    data['sessionId'] = sessionId;
    data['campaignId'] = campaignId;
    data['role'] = role;
    data['username'] = username;
    data['teamLeader'] = teamLeader;
    data['programManager'] = programManager;
    return data;
  }
}
