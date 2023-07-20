part of 'accounts_bloc.dart';

@immutable
abstract class AccountsEvent {}

class ShowAccountsNameEvent extends AccountsEvent {}

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
