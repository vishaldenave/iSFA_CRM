import 'dart:convert';

import 'package:http/http.dart';
import 'package:isfa_crm/assigned_accounts_module/models/assigned_accounts_model.dart';
import 'package:isfa_crm/assigned_accounts_module/models/update_current_model.dart';
import 'package:isfa_crm/utility/app_constants.dart';
import 'package:isfa_crm/utility/app_storage.dart';

class AssignedAccountsRepository {
  var userDetails = AppStorage().userDetail;
  Future<AssignedAccountsModel> getCurrentCaimpaign() async {
    final body = {
      "userId": userDetails?.userId,
      "sessionId": userDetails?.sessionId,
      "campaignListFor": "Current"
    };
    final response = await post(
        Uri.parse("${URLConstants.baseURLStart}/DenCRMCalling/api/getCampaign"),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return AssignedAccountsModel.fromRawJson(response.body);
    } else if (response.statusCode == 401) {
      throw "Failed";
    } else {
      throw response.body.isEmpty
          ? "Something went wrong"
          : json.decode(response.body)['message'] ?? "Something went wrong";
    }
  }

  Future<AssignedAccountsModel> getAllCaimpaign() async {
    final body = {
      "userId": userDetails?.userId,
      "sessionId": userDetails?.sessionId,
      "campaignListFor": "all"
    };
    final response = await post(
        Uri.parse("${URLConstants.baseURLStart}/DenCRMCalling/api/getCampaign"),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return AssignedAccountsModel.fromRawJson(response.body);
    } else if (response.statusCode == 401) {
      throw "Failed";
    } else {
      throw response.body.isEmpty
          ? "Something went wrong"
          : json.decode(response.body)['message'] ?? "Something went wrong";
    }
  }

  Future<UpdateCurrentModel> updateCurrentCaimpaign(int caimpaignId) async {
    final body = {
      "userId": userDetails?.userId,
      "sessionId": userDetails?.sessionId,
      "campaignId": caimpaignId
    };
    final response = await post(
        Uri.parse(
            "${URLConstants.baseURLStart}/DenCRMCalling/api/updateCampaign"),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return UpdateCurrentModel.fromRawJson(response.body);
    } else if (response.statusCode == 401) {
      throw "Failed";
    } else {
      throw response.body.isEmpty
          ? "Something went wrong"
          : json.decode(response.body)['message'] ?? "Something went wrong";
    }
  }
}
