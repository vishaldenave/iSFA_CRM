import 'dart:convert';

import 'package:http/http.dart';
import 'package:isfa_crm/login_module/models/login_model.dart';

import '../utility/app_constants.dart';

class LoginRepository {
  Future<LoginModel> login(
      {required String username, required String password}) async {
    final body = {"userId": username, "userPassword": password};
    final response = await post(
        Uri.parse("${URLConstants.baseURLStart}/DenCRMCalling/api/login"),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return LoginModel.fromRawJson(response.body);
    } else if (response.statusCode == 401) {
      throw "Incorrect username or password";
    } else {
      throw response.body.isEmpty
          ? "Something went wrong"
          : json.decode(response.body)['message'] ?? "Something went wrong";
    }
  }
}
