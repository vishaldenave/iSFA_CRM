import 'dart:convert';

class UpdateCurrentModel {
  UpdateCurrentModel({
    required this.status,
    required this.message,
    required this.statusCode,
  });
  late final String status;
  late final String message;
  late final int statusCode;

  factory UpdateCurrentModel.fromRawJson(String str) =>
      UpdateCurrentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  UpdateCurrentModel.fromJson(Map<String, dynamic> json) {
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
