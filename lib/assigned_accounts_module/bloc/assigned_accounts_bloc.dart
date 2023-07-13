import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isfa_crm/assigned_accounts_module/assigned_accounts_repository.dart';
import 'package:isfa_crm/assigned_accounts_module/models/assigned_accounts_model.dart';

part 'assigned_accounts_event.dart';
part 'assigned_accounts_state.dart';

class AssignedAccountsBloc
    extends Bloc<AssignedAccountsEvent, AssignedAccountsState> {
  AssignedAccountsRepository repo;
  CampaignList? current;
  List<CampaignList> allCampaign = [];

  AssignedAccountsBloc(this.repo) : super(AssignedAccountsInitial()) {
    on<AssignedAccountShowCurrentEvent>((event, emit) async {
      try {
        final accountResponse =
            await repo.getCurrentCaimpaign().catchError((onError) {
          throw onError.toString();
        });
        if (accountResponse.statusCode == 200) {
          if (accountResponse.campaignList.isNotEmpty) {
            current = accountResponse.campaignList.first;
          }
          // debugPrint(assignedCurrent!.campaignList.elementAt(0).campaignName);
          emit(AssignedAccountsCurrentState());
        }
      } catch (err) {
        throw err.toString();
      }
    });

    on<AssignedAccountShowAllEvent>((event, emit) async {
      try {
        final accountResponse =
            await repo.getAllCaimpaign().catchError((onError) {
          throw onError.toString();
        });
        if (accountResponse.statusCode == 200) {
          allCampaign = accountResponse.campaignList;
          emit(AssignedAccountsAllState());
        }
      } catch (err) {
        throw err.toString();
      }
    });

    on<AssignedAccountUpdateCurrentEvent>((event, emit) async {
      try {
        final accountResponse = await repo
            .updateCurrentCaimpaign(event.caimpaignId)
            .catchError((onError) {
          throw onError.toString();
        });
        if (accountResponse.statusCode == 200) {
          add(AssignedAccountShowCurrentEvent());
        }
      } catch (err) {
        throw err.toString();
      }
    });
  }
}
