part of 'accounts_bloc.dart';

@immutable
abstract class AccountsState {}

class AccountsInitial extends AccountsState {}

class ShowAccountsNameState extends AccountsState {}

class ShowSelectedAccountState extends AccountsState {}

class ShowContactListState extends AccountsState {}

class SearchState extends AccountsState {}

class ChangeState extends AccountsState {}

class AccountErrorMesssage extends AccountsState {
  final String message;
  AccountErrorMesssage(this.message);
}

class MoveToSaveFeedback extends AccountsState {
  final CallData callData;
  MoveToSaveFeedback(this.callData);
}
