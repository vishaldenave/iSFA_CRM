import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isfa_crm/call_disposition_module/callBloc/call_bloc.dart';
import 'package:isfa_crm/call_disposition_module/models/call_model.dart';
import 'package:isfa_crm/utility/app_constants.dart';
import 'package:isfa_crm/utility/extensions.dart';

class CallRepostoryHelper {
  Future<CallFeedbackBodyModel> submit(
      CallFeedbackModel feedback, File path, Emitter<CallState> emit) async {
    debugPrint(feedback.toRawJson());
    bool isExist = await path.exists();
    if (isExist) {
      debugPrint("File Exist");
    }
    final response = await Dio().post(
      "${URLConstants.baseURLStart}/DenCRMCalling/api/saveCallDetails",
      data: FormData.fromMap({
        "data": feedback.toRawJson().toString(),
        "file": await MultipartFile.fromFile(path.path, filename: path.name)
      }),
      onSendProgress: (count, total) {
        if (total != -1) {
          emit(ProgressState("${(count / total * 100).toStringAsFixed(0)}%"));
        }
      },
    ).catchError((onError) =>
        // ignore: invalid_return_type_for_catch_error
        emit(ErrorState(onError.toString())));
    if (response.statusCode == 200) {
      return CallFeedbackBodyModel.fromJson(response.data);
    } else {
      throw response.data.isEmpty
          ? "Something went wrong"
          : json.decode(response.data)['message'] ?? "Something went wrong";
    }
  }
}
