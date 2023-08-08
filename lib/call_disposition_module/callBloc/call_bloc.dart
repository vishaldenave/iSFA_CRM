import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isfa_crm/accounts_module/models/call_data.dart';
import 'package:isfa_crm/call_disposition_module/models/call_model.dart';
import 'package:isfa_crm/call_disposition_module/repositories/call_repository.dart';
import 'package:isfa_crm/utility/method_chanel.dart';

part 'call_event.dart';
part 'call_state.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  CallRepository repo;
  List<String>? callStatusList;
  List<ContactStatusList>? contactStatusList;
  List<String> callSubStatusList = [];
  final CallData callData;
  String? selectedCallStatus;
  ContactStatusList? selectedContactStatus;
  String? selectedCallSubStatus;
  TextEditingController remarksController = TextEditingController();

  CallBloc(this.repo, this.callData) : super(CallInitial()) {
    MyMethodChanel.end();
    on<SucessSubmitEvent>((event, emit) => emit(SucessFullSubmitState()));
    on<ShowCallStatusListEvent>((event, emit) async {
      try {
        final callStatusRespone =
            await repo.getCallStatus().catchError((onError) {
          throw onError.toString();
        });

        if (callStatusRespone.statusCode == 200) {
          callStatusList = callStatusRespone.callStatusList;
          emit(ShowCallStatusListState());
        } else {
          throw "Error";
        }
      } catch (err) {
        rethrow;
      }
    });

    on<OnChangeCallStatusEvent>((event, emit) async {
      selectedCallStatus = event.selectedCallStatus;
      emit(OnChangeCallStatusState());
    });

    on<ShowContactStatusListEvent>((event, emit) async {
      try {
        final callStatusRespone =
            await repo.getContactStatus().catchError((onError) {
          throw onError.toString();
        });

        if (callStatusRespone.statusCode == 200) {
          contactStatusList = callStatusRespone.contactStatusList;
          emit(ShowContactStatusListState());
        } else {
          throw "Error";
        }
      } catch (err) {
        rethrow;
      }
    });

    on<OnChangeContactStatusEvent>((event, emit) async {
      selectedContactStatus = event.selectedContactStatus;
      emit(OnChangeContactStatusState());
      add(ShowCallSubStatusListEvent(event.selectedContactStatus?.id ?? -1));
    });

    on<ShowCallSubStatusListEvent>((event, emit) async {
      try {
        final callStatusRespone =
            await repo.getCallSubStatus(event.id).catchError((onError) {
          throw onError.toString();
        });

        if (callStatusRespone.statusCode == 200) {
          callSubStatusList = callStatusRespone.contactSubStatusList;
          emit(ShowCallSubStatusListState());
        } else {
          throw "Error";
        }
      } catch (err) {
        rethrow;
      }
    });

    on<OnChangeCallSubStatusEvent>((event, emit) {
      selectedCallSubStatus = event.selectedCallSubStatus;
      emit(OnChangeCallSubStatusState());
    });

    on<OnSubmitFeedbackEvent>((event, emit) async {
      if (selectedCallStatus == null) {
        emit(ErrorState("Please choose call status"));
      } else if (selectedContactStatus == null) {
        emit(ErrorState("Please choose contact status"));
      } else if (selectedCallSubStatus == null) {
        emit(ErrorState("Please choose call sub status"));
      } else if (remarksController.text.isEmpty) {
        emit(ErrorState("Please enter remarks"));
      } else {
        CallFeedbackModel callFeedbackModel = CallFeedbackModel(
            userId: "",
            campaignId: callData.contactList.campaignId,
            orgId: callData.contactList.orgId,
            sessionId: "",
            contactId: callData.contactList.contactId ?? "",
            contactStatus: selectedContactStatus?.contactStatus ?? "",
            callStatus: selectedCallStatus ?? "",
            contactSubStatus: selectedCallSubStatus ?? "",
            remarks: remarksController.text,
            callDuration: callData.duration,
            callerId: "hi");
        emit(ProgressState(""));
        var callFeedbackBodyModel =
            await repo.saveFeedback(callFeedbackModel, callData.path, emit);
        if (callFeedbackBodyModel.statusCode == 200) {
          add(SucessSubmitEvent());
        } else {
          emit(ErrorState(callFeedbackBodyModel.message));
        }
      }
    });
  }
}
