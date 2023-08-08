import 'dart:convert';

import 'package:http/http.dart';
import 'package:isfa_crm/accounts_module/models/accounts_name_model.dart';
import 'package:isfa_crm/utility/app_storage.dart';

import '../utility/app_constants.dart';
import 'models/contact_list_model.dart';

class AccountsRepository {
  var userDetails = AppStorage().userDetail;
  Future<AccountsNameModel> getAccountname() async {
    final body = {
      "userId": userDetails?.userId,
      "sessionId": userDetails?.sessionId,
      "campaignId": AppStorage().currentCampaign?.campaignId ?? -1,
      "statusFor": "ORG"
    };
    final response = await post(
        Uri.parse(
            "${URLConstants.baseURLStart}/DenCRMCalling/api/getOrgContactList"),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return AccountsNameModel.fromRawJson(response.body);
    } else if (response.statusCode == 401) {
      throw "Failed";
    } else {
      throw response.body.isEmpty
          ? "Something went wrong"
          : json.decode(response.body)['message'] ?? "Something went wrong";
    }
  }

  Future<ContactListModel> getContactList(String orgId) async {
    final body = {
      "userId": userDetails?.userId,
      "sessionId": userDetails?.sessionId,
      "campaignId": userDetails?.campaignId,
      "statusFor": "CONTACT",
      "orgId": orgId
    };
    final response = await post(
        Uri.parse(
            "${URLConstants.baseURLStart}/DenCRMCalling/api/getOrgContactList"),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return ContactListModel.fromRawJson(response.body);
    } else if (response.statusCode == 401) {
      throw "Failed";
    } else {
      throw response.body.isEmpty
          ? "Something went wrong"
          : json.decode(response.body)['message'] ?? "Something went wrong";
    }
  }

  Future<AddContactModel> addContact(String orgId, String contactName,
      String designation, String mobile, String email) async {
    final body = {
      "userId": userDetails?.userId,
      "sessionId": userDetails?.sessionId,
      "campaignId": AppStorage().currentCampaign?.campaignId ?? -1,
      "orgId": orgId,
      "contactName": contactName,
      "designation": designation,
      "mobile": mobile,
      "email": email
    };
    final response = await post(
        Uri.parse("${URLConstants.baseURLStart}/DenCRMCalling/api/addContact"),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return AddContactModel.fromRawJson(response.body);
    } else if (response.statusCode == 401) {
      throw "Failed";
    } else {
      throw response.body.isEmpty
          ? "Something went wrong"
          : json.decode(response.body)['message'] ?? "Something went wrong";
    }
  }
}
