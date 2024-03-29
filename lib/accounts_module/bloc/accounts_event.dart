part of 'accounts_bloc.dart';

@immutable
abstract class AccountsEvent {}

class ShowAccountsNameEvent extends AccountsEvent {}

class ShowAddContactEvent extends AccountsEvent {}

class ShowSelectedAccountEvent extends AccountsEvent {
  final OrgList orgList;
  ShowSelectedAccountEvent(this.orgList);
}

class ShowContactListEvent extends AccountsEvent {
  final String orgId;
  ShowContactListEvent(this.orgId);
}

class SearchEvent extends AccountsEvent {
  final String value;
  SearchEvent(this.value);
}

class ChangeAccountSelectEvent extends AccountsEvent {
  final bool value;
  ChangeAccountSelectEvent(this.value);
}

class MakeCallEvent extends AccountsEvent {
  final ContactList contactList;
  MakeCallEvent(this.contactList);
}

class AddContactEvent extends AccountsEvent {
  final String orgId;
  AddContactEvent(this.orgId);
}
