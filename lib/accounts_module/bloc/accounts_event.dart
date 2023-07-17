part of 'accounts_bloc.dart';

@immutable
abstract class AccountsEvent {}

class ShowAccountsNameEvent extends AccountsEvent {}

class ShowSelectedAccountEvent extends AccountsEvent {
  final String accountName;
  final String orgId;
  ShowSelectedAccountEvent(this.accountName, this.orgId);
}

class ShowContactListEvent extends AccountsEvent {
  final String orgId;
  ShowContactListEvent(this.orgId);
}

class SearchEvent extends AccountsEvent {
  final String value;
  SearchEvent(this.value);
}
