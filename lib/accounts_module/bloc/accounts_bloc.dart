import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isfa_crm/accounts_module/accounts_repository.dart';
import 'package:isfa_crm/accounts_module/models/accounts_name_model.dart';
import 'package:isfa_crm/accounts_module/models/call_data.dart';
import 'package:isfa_crm/accounts_module/models/contact_list_model.dart';
import 'package:isfa_crm/utility/method_chanel.dart';
import 'package:path_provider/path_provider.dart';

part 'accounts_event.dart';
part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsRepository repo;
  List<OrgList> orgList = [];
  List<OrgList> filteredList = [];
  List<ContactList> contactList = [];
  bool isAccountNameSelecting = false;
  bool showContants = false;
  bool showAddContactDialog = false;
  OrgList? selectedOrg;
  TextEditingController nameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  AccountsBloc(this.repo) : super(AccountsInitial()) {
    on<ChangeAccountSelectEvent>((event, emit) =>
        {isAccountNameSelecting = event.value, emit(ChangeState())});
    on<ShowAccountsNameEvent>((event, emit) async {
      try {
        final accountResponse =
            await repo.getAccountname().catchError((onError) {
          throw onError.toString();
        });
        orgList = accountResponse.orgList;
        filteredList = orgList;
        emit(ShowAccountsNameState());
      } catch (err) {
        throw err.toString();
      }
    });

    on<ShowSelectedAccountEvent>((event, emit) {
      selectedOrg = event.orgList;
      add(ShowContactListEvent(event.orgList.orgId));
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
    on<MakeCallEvent>((event, emit) async {
      bool hasAssessability = await MyMethodChanel.hasAssessability();
      if (hasAssessability) {
        if (await MyMethodChanel.hasPermissions) {
          const MethodChannel("audio_received")
              .setMethodCallHandler((call) async {
            switch (call.method) {
              case "audioFile":
                String path = call.arguments['path'];
                String duration = call.arguments['duration'];

                debugPrint("File path  - $path");

                emit(MoveToSaveFeedback(CallData(File.fromUri(Uri(path: path)),
                    duration, event.contactList)));
                break;
            }
          });
          var path = "${(await getExternalStorageDirectory())?.path}";

          await MyMethodChanel.start(event.contactList.contactName ?? "",
              event.contactList.mobile ?? "", path);
        } else {
          emit(AccountErrorMesssage(
              "Please open application settings & give available permissions to application."));
        }
      } else {
        emit(AccountErrorMesssage(
            "Please Provide Accessibility to the Application"));
      }
    });

    on<AddContactEvent>((event, emit) async {
      try {
        final addContactResponse = await repo
            .addContact(
                event.orgId,
                nameController.text,
                designationController.text,
                mobileController.text,
                emailController.text)
            .catchError((onError) {
          throw onError.toString();
        });
        if (addContactResponse.statusCode == 200) {
          nameController.text = "";
          designationController.text = "";
          mobileController.text = "";
          emailController.text = "";
          emit(SuccessAddContactState(addContactResponse.message));
        } else {
          emit(FailedAddContactState(addContactResponse.message));
        }
      } catch (err) {
        throw err.toString();
      }
    });

    on<ShowAddContactEvent>((event, emit) {
      emit(ShowAddContactState());
    });
  }
}
