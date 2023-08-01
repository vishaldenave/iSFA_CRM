import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:isfa_crm/call_disposition_module/models/call_model.dart';
import 'package:isfa_crm/call_disposition_module/repositories/repository_helper.dart';
import 'package:isfa_crm/utility/app_storage.dart';
import '../../utility/app_constants.dart';

class CallRepository {
  var userDetails = AppStorage().userDetail;
  Future<CallStatusModel> getCallStatus() async {
    final body = {
      "userId": userDetails?.userId,
      "sessionId": userDetails?.sessionId,
      "campaignId": userDetails?.campaignId,
      "statusFor": "call"
    };
    final response = await post(
        Uri.parse(
            "${URLConstants.baseURLStart}/DenCRMCalling/api/getCallContStatus"),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return CallStatusModel.fromRawJson(response.body);
    } else if (response.statusCode == 401) {
      throw "Error";
    } else {
      throw response.body.isEmpty
          ? "Something went wrong"
          : json.decode(response.body)['message'] ?? "Something went wrong";
    }
  }

  Future<ContactStatusModel> getContactStatus() async {
    final body = {
      "userId": userDetails?.userId,
      "sessionId": userDetails?.sessionId,
      "campaignId": userDetails?.campaignId,
      "statusFor": "contact"
    };
    final response = await post(
        Uri.parse(
            "${URLConstants.baseURLStart}/DenCRMCalling/api/getCallContStatus"),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return ContactStatusModel.fromRawJson(response.body);
    } else if (response.statusCode == 401) {
      throw "Error";
    } else {
      throw response.body.isEmpty
          ? "Something went wrong"
          : json.decode(response.body)['message'] ?? "Something went wrong";
    }
  }

  Future<CallSubStatusModel> getCallSubStatus(int id) async {
    final body = {
      "userId": userDetails?.userId,
      "sessionId": userDetails?.sessionId,
      "campaignId": userDetails?.campaignId,
      "contactStatusId": id,
      "statusFor": "contact_sub"
    };
    final response = await post(
        Uri.parse(
            "${URLConstants.baseURLStart}/DenCRMCalling/api/getCallContStatus"),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return CallSubStatusModel.fromRawJson(response.body);
    } else if (response.statusCode == 401) {
      throw "Error";
    } else {
      throw response.body.isEmpty
          ? "Something went wrong"
          : json.decode(response.body)['message'] ?? "Something went wrong";
    }
  }

  Future<CallFeedbackBodyModel> saveFeedback(
      CallFeedbackModel feedback, String path) async {
    feedback.userId = userDetails?.userId ?? "-1";
    feedback.sessionId = userDetails?.sessionId ?? "";
    return await CallRepostoryHelper().submit(feedback, path);
  }
}
