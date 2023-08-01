import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isfa_crm/accounts_module/models/call_data.dart';
import 'package:isfa_crm/call_disposition_module/models/call_model.dart';
import 'package:isfa_crm/call_disposition_module/repositories/call_repository.dart';

part 'call_event.dart';
part 'call_state.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  CallRepository repo;
  List<String>? callStatus;
  List<ContactStatusList>? contactStatus;
  List<String>? callSubStatus;
  final CallData callData;

  CallBloc(this.repo, this.callData) : super(CallInitial()) {
    on<ShowCallStatusListEvent>((event, emit) async {
      try {
        final callStatusRespone =
            await repo.getCallStatus().catchError((onError) {
          throw onError.toString();
        });

        if (callStatusRespone.statusCode == 200) {
          callStatus = callStatusRespone.callStatusList;
          emit(ShowCallStatusListState());
        } else {
          throw "Error";
        }
      } catch (err) {
        rethrow;
      }
    });

    on<OnChangeCallStatusEvent>((event, emit) async {
      add(ShowContactStatusListEvent());
      emit(OnChangeCallStatusState());
    });

    on<ShowContactStatusListEvent>((event, emit) async {
      try {
        final callStatusRespone =
            await repo.getContactStatus().catchError((onError) {
          throw onError.toString();
        });

        if (callStatusRespone.statusCode == 200) {
          contactStatus = callStatusRespone.contactStatusList;
          emit(ShowContactStatusListState());
        } else {
          throw "Error";
        }
      } catch (err) {
        rethrow;
      }
    });

    on<OnChangeContactStatusEvent>((event, emit) async {
      emit(OnChangeContactStatusState());
      add(ShowCallSubStatusListEvent(event.id));
    });

    on<ShowCallSubStatusListEvent>((event, emit) async {
      try {
        final callStatusRespone =
            await repo.getCallSubStatus(event.id).catchError((onError) {
          throw onError.toString();
        });

        if (callStatusRespone.statusCode == 200) {
          callSubStatus = callStatusRespone.contactSubStatusList;
          emit(ShowCallSubStatusListState());
        } else {
          throw "Error";
        }
      } catch (err) {
        rethrow;
      }
    });

    on<OnChangeCallSubStatusEvent>((event, emit) {
      emit(OnChangeCallSubStatusState());
    });

    on<OnSubmitFeedbackEvent>((event, emit) async {});
  }
}
