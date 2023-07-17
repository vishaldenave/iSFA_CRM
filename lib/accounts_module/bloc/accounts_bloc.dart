import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isfa_crm/accounts_module/accounts_repository.dart';
import 'package:isfa_crm/accounts_module/models/accounts_name_model.dart';
import 'package:isfa_crm/accounts_module/models/contact_list_model.dart';

part 'accounts_event.dart';
part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsRepository repo;
  List<OrgList> orgList = [];
  List<OrgList> filteredList = [];
  String showSelectedName = "";
  List<ContactList> contactList = [];

  AccountsBloc(this.repo) : super(AccountsInitial()) {
    on<ShowAccountsNameEvent>((event, emit) async {
      try {
        // final campaignIdRes = await AssignedAccountsRepository()
        //     .getCurrentCaimpaign()
        //     .catchError((onError) {
        //   throw onError.toString();
        // });
        // if (campaignIdRes.statusCode == 200) {
        //   if (campaignIdRes.campaignList.isNotEmpty) {
        //     campaignId = campaignIdRes.campaignList.first.campaignId;
        //   }
        // }

        final accountResponse =
            await repo.getAccountname().catchError((onError) {
          throw onError.toString();
        });
        // if (accountResponse.statusCode == 200) {
        //   if (accountResponse.orgList.isNotEmpty) {

        //   }

        // }
        orgList = accountResponse.orgList;
        filteredList = orgList;
        emit(ShowAccountsNameState());
      } catch (err) {
        throw err.toString();
      }
    });

    on<ShowSelectedAccountEvent>((event, emit) {
      showSelectedName = event.accountName;
      add(ShowContactListEvent(event.orgId));
    });

    on<ShowContactListEvent>((event, emit) async {
      try {
        final contactResponse =
            await repo.getContactList(event.orgId).catchError((onError) {
          throw onError.toString();
        });
        if (contactResponse.statusCode == 200) {
          if (contactResponse.contactList.isNotEmpty) {
            contactList = contactResponse.contactList;
            emit(ShowContactListState());
            emit(ShowSelectedAccountState());
          }
        }
      } catch (err) {
        throw err.toString();
      }
    });

    on<SearchEvent>((event, emit) {
      if (event.value.isNotEmpty) {
        filteredList = orgList
            .where((element) => element.orgName
                .toLowerCase()
                .contains(event.value.toLowerCase()))
            .toList();
      } else {
        filteredList = orgList;
      }
      emit(SearchState());
    });
  }
}
