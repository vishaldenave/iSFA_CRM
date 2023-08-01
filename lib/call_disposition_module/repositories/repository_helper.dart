import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:isfa_crm/call_disposition_module/models/call_model.dart';
import 'package:isfa_crm/utility/app_constants.dart';

class CallRepostoryHelper {
  Future<CallFeedbackBodyModel> submit(
      CallFeedbackModel feedback, String path) async {
    final dio = Dio();

    var callFormData = FormData.fromMap({
      'data': feedback.toRawJson(),
      'file': await MultipartFile.fromFile(path)
    });
    final response = await dio.post(
      "${URLConstants.baseURLStart}/DenCRMCalling/api/saveCallDetails",
      data: callFormData,
      onSendProgress: (count, total) {
        if (total != -1) {
          var percentage = (count / total * 100).toStringAsFixed(0);
        }
      },
    );
    if (response.statusCode == 200) {
      return CallFeedbackBodyModel.fromRawJson(response.data);
    } else if (response.statusCode == 401) {
      throw "Error";
    } else {
      throw response.data.isEmpty
          ? "Something went wrong"
          : json.decode(response.data)['message'] ?? "Something went wrong";
    }
  }
}
